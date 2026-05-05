
PROGRAM _INIT

	OpcConnect.Step := 0;
	OpcReadfile.Step := 0;
	
END_PROGRAM

PROGRAM _CYCLIC

	(* UA_Connect - establish connection to OPC-UA Server *)

	CASE OpcConnect.Step OF
		0: 
			OpcConnect.SessionConnectInfo.SecurityMsgMode := UASMM_None;
			OpcConnect.SessionConnectInfo.SecurityPolicy := UASP_None;
			OpcConnect.SessionConnectInfo.TransportProfile := UATP_UATcp;
			OpcConnect.SessionConnectInfo.UserIdentityToken.UserIdentityTokenType := UAUITT_Username;
			OpcConnect.SessionConnectInfo.UserIdentityToken.TokenParam1 := 'admin';
			OpcConnect.SessionConnectInfo.UserIdentityToken.TokenParam2 := 'password';
			OpcConnect.SessionConnectInfo.SessionTimeout := T#1m;
			OpcConnect.SessionConnectInfo.MonitorConnection := T#10s;
			OpcConnect.UA_Connect_0 (Execute := FALSE);
			OpcConnect.Step := OpcConnect.Step + 1;
		1: // connect to server
			OpcConnect.UA_Connect_0 (Execute := TRUE,
				ServerEndpointUrl := 'opc.tcp://localhost:4840',
				SessionConnectInfo := OpcConnect.SessionConnectInfo,
				Timeout := T#10s);
			IF (OpcConnect.UA_Connect_0.Busy = FALSE) THEN
				IF (OpcConnect.UA_Connect_0.Done = TRUE) THEN
					OpcConnect.ErrorID:= 0;
					OpcConnect.ConnectionHdl := OpcConnect.UA_Connect_0.ConnectionHdl;
					OpcConnect.Step := OpcConnect.Step + 1;
				END_IF
				IF (OpcConnect.UA_Connect_0.Error = TRUE) THEN
					OpcConnect.ErrorID:= OpcConnect.UA_Connect_0.ErrorID;
					OpcConnect.ConnectionHdl := 0;
					OpcConnect.Step := OpcConnect.Step + 10000;
				END_IF
			END_IF
		2: // read index of required namespace
			OpcConnect.UA_GetNamespaceIndex_0 (Execute := FALSE);
			OpcConnect.Step := OpcConnect.Step + 1;
		3:
			OpcConnect.UA_GetNamespaceIndex_0 (Execute := TRUE,
				ConnectionHdl := OpcConnect.ConnectionHdl,
				NamespaceUri := 'http://br-automation.com/OpcUa/FileTransfer/',
				Timeout := T#5s);
			IF (OpcConnect.UA_GetNamespaceIndex_0.Busy = FALSE) THEN
				IF (OpcConnect.UA_GetNamespaceIndex_0.Done = TRUE) THEN
					OpcConnect.ErrorID:= 0;
					OpcConnect.NamespaceIndexFiles := OpcConnect.UA_GetNamespaceIndex_0.NamespaceIndex;
					OpcConnect.Step := OpcConnect.Step + 1;
				END_IF
				IF (OpcConnect.UA_GetNamespaceIndex_0.Error = TRUE) THEN
					OpcConnect.ErrorID := OpcConnect.UA_GetNamespaceIndex_0.ErrorID;
					OpcConnect.NamespaceIndexFiles := 0;
					OpcConnect.Step := OpcConnect.Step + 10000;
				END_IF
			END_IF
	END_CASE;

	(* Open and Read file*)

	CASE OpcReadfile.Step OF
		0: // wait for connect
			IF OpcConnect.NamespaceIndexFiles > 0 THEN
				OpcReadfile.Step := OpcReadfile.Step + 1;
			END_IF
		1: //prepare Open method handle
			OpcReadfile.ObjectNodeID_Op.NamespaceIndex := OpcConnect.NamespaceIndexFiles;
			OpcReadfile.ObjectNodeID_Op.Identifier := '5005';
			OpcReadfile.ObjectNodeID_Op.IdentifierType := UAIT_Numeric;
			OpcReadfile.MethodNodeID_Op.NamespaceIndex := OpcConnect.NamespaceIndexFiles;
			OpcReadfile.MethodNodeID_Op.Identifier := '7011';
			OpcReadfile.MethodNodeID_Op.IdentifierType := UAIT_Numeric;
			OpcReadfile.UA_MethodGetHandle_Op (Execute := FALSE);
			OpcReadfile.Step := OpcReadfile.Step + 1;
		2: // get Open method handle
			OpcReadfile.UA_MethodGetHandle_Op (Execute := TRUE,
				ConnectionHdl := OpcConnect.ConnectionHdl,
				ObjectNodeID := OpcReadfile.ObjectNodeID_Op,
				MethodNodeID := OpcReadfile.MethodNodeID_Op,
				Timeout := T#10s);
			IF (OpcReadfile.UA_MethodGetHandle_Op.Busy = FALSE) THEN
				IF (OpcReadfile.UA_MethodGetHandle_Op.Done = TRUE) THEN
					OpcReadfile.ErrorID := 0;
					OpcReadfile.MethodHdl_Op := OpcReadfile.UA_MethodGetHandle_Op.MethodHdl;
					OpcReadfile.Step := OpcReadfile.Step + 1;
				END_IF
				IF (OpcReadfile.UA_MethodGetHandle_Op.Error = TRUE) THEN
					OpcReadfile.ErrorID := OpcReadfile.UA_MethodGetHandle_Op.ErrorID;
					OpcReadfile.MethodHdl_Op := 0;
					OpcReadfile.Step := OpcReadfile.Step + 10000;
				END_IF
			END_IF
		3: // prepare Open method call
			OpcReadfile.InputArguments_Op[0].Name := 'Mode';
			OpcReadfile.InputArguments_Op[0].Value := 'OpcReadfile.OpenMode';
			OpcReadfile.OutputArguments_Op[0].Name := 'FileHandle';
			OpcReadfile.OutputArguments_Op[0].Value := 'OpcReadfile.FileHandle';
			OpcReadfile.OpenMode := 3;
			OpcReadfile.UA_MethodCall_Op (
				Execute := FALSE,
				InputArguments := OpcReadfile.InputArguments_Op,
			OutputArguments := OpcReadfile.OutputArguments_Op,
			MethodResult := OpcReadfile.MethodResult_Op );
			OpcReadfile.Step := OpcReadfile.Step + 1;
		4: // call Open method
			OpcReadfile.UA_MethodCall_Op (Execute := TRUE,
				ConnectionHdl := OpcConnect.ConnectionHdl,
				MethodHdl := OpcReadfile.MethodHdl_Op,
				Timeout := T#10s,
				InputArguments := OpcReadfile.InputArguments_Op,
			OutputArguments := OpcReadfile.OutputArguments_Op,
			MethodResult := OpcReadfile.MethodResult_Op);
			IF (OpcReadfile.UA_MethodCall_Op.Busy = FALSE) THEN
				IF (OpcReadfile.UA_MethodCall_Op.Done = TRUE) THEN
					OpcReadfile.ErrorID := 0;
					OpcReadfile.Step := OpcReadfile.Step + 1;
				END_IF
				IF (OpcReadfile.UA_MethodCall_Op.Error = TRUE) THEN
					OpcReadfile.ErrorID := OpcReadfile.UA_MethodCall_Op.ErrorID;
					OpcReadfile.Step := OpcReadfile.Step + 10000;
				END_IF
			END_IF
		5: //prepare Read method handle
			OpcReadfile.ObjectNodeID_Rd.NamespaceIndex := OpcConnect.NamespaceIndexFiles;
			OpcReadfile.ObjectNodeID_Rd.Identifier := '5005';
			OpcReadfile.ObjectNodeID_Rd.IdentifierType := UAIT_Numeric;
			OpcReadfile.MethodNodeID_Rd.NamespaceIndex := OpcConnect.NamespaceIndexFiles;
			OpcReadfile.MethodNodeID_Rd.Identifier := '7012';
			OpcReadfile.MethodNodeID_Rd.IdentifierType := UAIT_Numeric;
			OpcReadfile.UA_MethodGetHandle_Rd (Execute := FALSE);
			OpcReadfile.Step := OpcReadfile.Step + 1;
		6: // get Read method handle
			OpcReadfile.UA_MethodGetHandle_Rd (Execute := TRUE,
				ConnectionHdl := OpcConnect.ConnectionHdl,
				ObjectNodeID := OpcReadfile.ObjectNodeID_Rd,
				MethodNodeID := OpcReadfile.MethodNodeID_Rd,
				Timeout := T#10s);
			IF (OpcReadfile.UA_MethodGetHandle_Rd.Busy = FALSE) THEN
				IF (OpcReadfile.UA_MethodGetHandle_Rd.Done = TRUE) THEN
					OpcReadfile.ErrorID := 0;
					OpcReadfile.MethodHdl_Rd := OpcReadfile.UA_MethodGetHandle_Rd.MethodHdl;
					OpcReadfile.Step := OpcReadfile.Step + 1;
				END_IF
				IF (OpcReadfile.UA_MethodGetHandle_Rd.Error = TRUE) THEN
					OpcReadfile.ErrorID := OpcReadfile.UA_MethodGetHandle_Rd.ErrorID;
					OpcReadfile.MethodHdl_Rd := 0;
					OpcReadfile.Step := OpcReadfile.Step + 10000;
				END_IF
			END_IF
		7: // prepare Read method call
			OpcReadfile.InputArguments_Rd[0].Name := 'FileHandle';
			OpcReadfile.InputArguments_Rd[0].Value := 'OpcReadfile.FileHandle';
			OpcReadfile.InputArguments_Rd[1].Name := 'Length';
			OpcReadfile.InputArguments_Rd[1].Value := 'OpcReadfile.Length';
			OpcReadfile.OutputArguments_Rd[0].Name := 'Data';
			OpcReadfile.OutputArguments_Rd[0].Value := 'OpcReadfile.Data';
			OpcReadfile.Length := 10;
			OpcReadfile.UA_MethodCall_Rd (Execute := FALSE,
				InputArguments := OpcReadfile.InputArguments_Rd,
			OutputArguments := OpcReadfile.OutputArguments_Rd,
			MethodResult := OpcReadfile.MethodResult_Rd);
			OpcReadfile.Step := OpcReadfile.Step + 1;
		8: // call Read method
			OpcReadfile.UA_MethodCall_Rd (Execute := TRUE,
				ConnectionHdl := OpcConnect.ConnectionHdl,
				MethodHdl := OpcReadfile.MethodHdl_Rd,
				Timeout := T#10s,
				InputArguments := OpcReadfile.InputArguments_Rd,
			OutputArguments := OpcReadfile.OutputArguments_Rd,
			MethodResult := OpcReadfile.MethodResult_Rd);
			IF (OpcReadfile.UA_MethodCall_Rd.Busy = FALSE) THEN
				IF (OpcReadfile.UA_MethodCall_Rd.Done = TRUE) THEN
					OpcReadfile.ErrorID := 0;
					OpcReadfile.Step := OpcReadfile.Step + 1;
				END_IF
				IF (OpcReadfile.UA_MethodCall_Rd.Error = TRUE) THEN
					OpcReadfile.ErrorID := OpcReadfile.UA_MethodCall_Rd.ErrorID;
					OpcReadfile.Step := OpcReadfile.Step + 10000;
				END_IF
			END_IF
		9: //prepare Close method handle
			OpcReadfile.ObjectNodeID_Cl.NamespaceIndex := OpcConnect.NamespaceIndexFiles;
			OpcReadfile.ObjectNodeID_Cl.Identifier := '5005';
			OpcReadfile.ObjectNodeID_Cl.IdentifierType := UAIT_Numeric;
			OpcReadfile.MethodNodeID_Cl.NamespaceIndex := OpcConnect.NamespaceIndexFiles;
			OpcReadfile.MethodNodeID_Cl.Identifier := '7009';
			OpcReadfile.MethodNodeID_Cl.IdentifierType := UAIT_Numeric;
			OpcReadfile.UA_MethodGetHandle_Cl (Execute := FALSE);
			OpcReadfile.Step := OpcReadfile.Step + 1;
		10: // get Close method handle
			OpcReadfile.UA_MethodGetHandle_Cl (Execute := TRUE,
			ConnectionHdl := OpcConnect.ConnectionHdl,
			ObjectNodeID := OpcReadfile.ObjectNodeID_Cl,
			MethodNodeID := OpcReadfile.MethodNodeID_Cl,
			Timeout := T#10s);
			IF (OpcReadfile.UA_MethodGetHandle_Cl.Busy = FALSE) THEN
				IF (OpcReadfile.UA_MethodGetHandle_Cl.Done = TRUE) THEN
					OpcReadfile.ErrorID := 0;
					OpcReadfile.MethodHdl_Cl := OpcReadfile.UA_MethodGetHandle_Cl.MethodHdl;
					OpcReadfile.Step := OpcReadfile.Step + 1;
				END_IF
				IF (OpcReadfile.UA_MethodGetHandle_Cl.Error = TRUE) THEN
					OpcReadfile.ErrorID := OpcReadfile.UA_MethodGetHandle_Cl.ErrorID;
					OpcReadfile.MethodHdl_Cl := 0;
					OpcReadfile.Step := OpcReadfile.Step + 10000;
				END_IF
			END_IF
		11: // prepare Close method call
			OpcReadfile.InputArguments_Cl[0].Name := 'FileHandle';
			OpcReadfile.InputArguments_Cl[0].Value := 'OpcReadfile.FileHandle';
			OpcReadfile.OutputArguments_Cl[0].Name := '';
			OpcReadfile.OutputArguments_Cl[0].Value := '';
			OpcReadfile.UA_MethodCall_Cl (Execute := FALSE,
			InputArguments := OpcReadfile.InputArguments_Cl,
			OutputArguments := OpcReadfile.OutputArguments_Cl,
			MethodResult := OpcReadfile.MethodResult_Cl);
			OpcReadfile.Step := OpcReadfile.Step + 1;
		12: // call Close method
			OpcReadfile.UA_MethodCall_Cl (Execute := TRUE,
			ConnectionHdl := OpcConnect.ConnectionHdl,
			MethodHdl := OpcReadfile.MethodHdl_Cl,
			Timeout := T#10s,
			InputArguments := OpcReadfile.InputArguments_Cl,
			OutputArguments := OpcReadfile.OutputArguments_Cl,
			MethodResult := OpcReadfile.MethodResult_Cl);
			IF (OpcReadfile.UA_MethodCall_Cl.Busy = FALSE) THEN
				IF (OpcReadfile.UA_MethodCall_Cl.Done = TRUE) THEN
					OpcReadfile.ErrorID := 0;
					OpcReadfile.Step := OpcReadfile.Step + 1;
				END_IF
				IF (OpcReadfile.UA_MethodCall_Cl.Error = TRUE) THEN
					OpcReadfile.ErrorID := OpcReadfile.UA_MethodCall_Cl.ErrorID;
					OpcReadfile.Step := OpcReadfile.Step + 10000;
				END_IF
			END_IF
		
	END_CASE;
	
END_PROGRAM

PROGRAM _EXIT
			(* Insert code here *)
	 
			END_PROGRAM

