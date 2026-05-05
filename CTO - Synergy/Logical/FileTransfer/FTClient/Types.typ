
TYPE
	OpcConnectType : 	STRUCT 
		Step : INT;
		ErrorID : DWORD;
		SessionConnectInfo : UASessionConnectInfo;
		UA_Connect_0 : UA_Connect;
		ConnectionHdl : DWORD;
		UA_GetNamespaceIndex_0 : UA_NamespaceGetIndex;
		NamespaceIndexFiles : UINT;
	END_STRUCT;
	OpcReadfileType : 	STRUCT 
		Step : INT;
		ErrorID : DWORD;
		ObjectNodeID_Op : UANodeID;
		MethodNodeID_Op : UANodeID;
		UA_MethodGetHandle_Op : UA_MethodGetHandle;
		MethodHdl_Op : DWORD := 0;
		InputArguments_Op : ARRAY[0..9]OF BrUaMethodArgument;
		OutputArguments_Op : ARRAY[0..9]OF BrUaMethodArgument;
		UA_MethodCall_Op : UA_MethodCall;
		MethodResult_Op : DWORD;
		OpenMode : BYTE;
		FileHandle : UDINT;
		ObjectNodeID_Rd : UANodeID;
		MethodNodeID_Rd : UANodeID;
		UA_MethodGetHandle_Rd : UA_MethodGetHandle;
		MethodHdl_Rd : DWORD := 0;
		InputArguments_Rd : ARRAY[0..9]OF BrUaMethodArgument;
		OutputArguments_Rd : ARRAY[0..9]OF BrUaMethodArgument;
		UA_MethodCall_Rd : UA_MethodCall;
		MethodResult_Rd : DWORD;
		Length : DINT;
		Data : UAByteString5000;
		ObjectNodeID_Cl : UANodeID;
		MethodNodeID_Cl : UANodeID;
		UA_MethodGetHandle_Cl : UA_MethodGetHandle;
		MethodHdl_Cl : DWORD := 0;
		InputArguments_Cl : ARRAY[0..9]OF BrUaMethodArgument;
		OutputArguments_Cl : ARRAY[0..9]OF BrUaMethodArgument;
		UA_MethodCall_Cl : UA_MethodCall;
		MethodResult_Cl : DWORD;
	END_STRUCT;
	UAByteString5000 : 	STRUCT  (* Byte string containing length and data	*)
		Length : DINT;
		Data : ARRAY[0..4999]OF USINT;
	END_STRUCT;
END_TYPE
