FUNCTION_BLOCK UaFileSystem (* file system implementation *)
	IF Execute = FALSE THEN
		Step := 0;
	END_IF;
	CASE Step OF
		0:
			// Prepare File Systems
			UaSrv_GetNamespaceIndex_0(Execute := FALSE);
			Step := Step + 1;
		1:
			// Get NamspacIndex of File SystemNamespace
			UaSrv_GetNamespaceIndex_0 (Execute := TRUE,
				NamespaceUri := NamespaceUri);
			IF (UaSrv_GetNamespaceIndex_0.Busy = 0) THEN
				IF (UaSrv_GetNamespaceIndex_0.Done = 1) THEN
					NamespaceIndex := UaSrv_GetNamespaceIndex_0.NamespaceIndex;
					brsitoa(NamespaceIndex,ADR(NamespaceIndexs));
					ErrorID := 0;
					Step := Step + 1;
				END_IF
				IF (UaSrv_GetNamespaceIndex_0.Error = 1) THEN
					NamespaceIndex := 0;
					ErrorID := UaSrv_GetNamespaceIndex_0.Error;
					Step := Step + 10000;
				END_IF
			END_IF
		2:
			// Standardized comment added by Viraj
			//Execute method open ()

			CASE BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.Step OF
				0: // start operate
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.UaSrv_MethodOperate(Execute := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.Step := 10;
				10: // check if method called
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.UaSrv_MethodOperate(Execute := TRUE,
						Action  := UaMoa_CheckIsCalled,
						MethodName := 'File1_Open');
					IF NOT BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.UaSrv_MethodOperate.Busy THEN
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.UaSrv_MethodOperate.Done THEN
							IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.UaSrv_MethodOperate.IsCalled THEN
								BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.Step := 20; // method is called
							ELSE
								BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.Step := 0; // again
							END_IF
						END_IF
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.UaSrv_MethodOperate.Error THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.LastErrorID := BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.UaSrv_MethodOperate.ErrorID;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.Step := 0;
						END_IF
					END_IF
				20: // Execute method code
					FileOpen_0(enable := FALSE);
					IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.mode = 1 THEN
						fiMode := fiREAD_ONLY;
					ELSE
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.mode = 2 THEN
							fiMode := fiWRITE_ONLY;
						ELSE
							IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.mode = 3 THEN
								fiMode := fiREAD_WRITE;
							END_IF
						END_IF
					END_IF 
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.Step := 21;
				21:
					FileOpen_0(enable := TRUE, pDevice := ADR(BrFileDevices.FileDevice1.Path), pFile := ADR(BrFileDevices.FileDevice1.FileSystem.Dir1.File1.FileName), mode := fiMode);
					IF NOT (FileOpen_0.status = 65535) THEN
						IF FileOpen_0.status = 0 THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.fileHandle := FileOpen_0.ident;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Size := FileOpen_0.filelen;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.OpenCount := BrFileDevices.FileDevice1.FileSystem.Dir1.File1.OpenCount +1;
							fiOffset := 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.UaSrv_MethodOperate.MethodResult := 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.Step := 30;
						ELSIF FileOpen_0.status = fiERR_FILE_NOT_FOUND THEN							
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.fileHandle := 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Size := 0;
							fiOffset := 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.UaSrv_MethodOperate.MethodResult := 16#803e0000;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.Step := 30;							
						ELSE
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.fileHandle := 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Size := 0;
							fiOffset := 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.UaSrv_MethodOperate.MethodResult := 16#80010000;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.Step := 30;							
						END_IF
					END_IF
				30: // finish operate 
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.UaSrv_MethodOperate(Execute := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.Step := 40;
				40: // finish method 
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.UaSrv_MethodOperate(Execute := TRUE,
						Action  := UaMoa_Finished);
					IF NOT BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.UaSrv_MethodOperate.Busy THEN
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.UaSrv_MethodOperate.Done THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.LastErrorID:= 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.Step := 0; // method is finished, wait again for call
						END_IF
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.UaSrv_MethodOperate.Error THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.LastErrorID:= BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.UaSrv_MethodOperate.ErrorID;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Open.Step := 0;
						END_IF
					END_IF
			END_CASE;
	
			// execute method Close()

			CASE BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.Step OF
				0: // start operate
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.UaSrv_MethodOperate(Execute := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.Step := 10;
				10: // check if method called
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.UaSrv_MethodOperate(Execute := TRUE,
						Action  := UaMoa_CheckIsCalled,
						MethodName := 'File1_Close');
					IF NOT BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.UaSrv_MethodOperate.Busy THEN
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.UaSrv_MethodOperate.Done THEN
							IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.UaSrv_MethodOperate.IsCalled THEN
								BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.Step := 20; // method is called
							ELSE
								BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.Step := 0; // again
							END_IF
						END_IF
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.UaSrv_MethodOperate.Error THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.LastErrorID := BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.UaSrv_MethodOperate.ErrorID;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.Step := 0;
						END_IF
					END_IF
				20: // Execute method code
					FileClose_0(enable := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.Step := 21;
				21:
					FileClose_0(enable := TRUE, ident := BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.fileHandle);
					IF NOT (FileClose_0.status = 65535) THEN
						IF FileClose_0.status = 0 THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Size := 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.OpenCount := BrFileDevices.FileDevice1.FileSystem.Dir1.File1.OpenCount -1;
							fiOffset := 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.UaSrv_MethodOperate.MethodResult := 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.Step := 30;
						ELSE
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.UaSrv_MethodOperate.MethodResult := 16#80010000;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.Step := 30;
						END_IF
					END_IF
				30: // finish operate 
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.UaSrv_MethodOperate(Execute := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.Step := 40;
				40: // finish method 
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.UaSrv_MethodOperate(Execute := TRUE,
						Action  := UaMoa_Finished);
					IF NOT BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.UaSrv_MethodOperate.Busy THEN
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.UaSrv_MethodOperate.Done THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.LastErrorID:= 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.Step := 0; // method is finished, wait again for call
						END_IF
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.UaSrv_MethodOperate.Error THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.LastErrorID:= BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.UaSrv_MethodOperate.ErrorID;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Close.Step := 0;
						END_IF
					END_IF
			END_CASE;
		
			// Execute method Read()

			CASE BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.Step OF
				0: // start operate
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.UaSrv_MethodOperate(Execute := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.Step := 10;
				10: // check if method called
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.UaSrv_MethodOperate(Execute := TRUE,
						Action  := UaMoa_CheckIsCalled,
						MethodName := 'File1_Read');
					IF NOT BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.UaSrv_MethodOperate.Busy THEN
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.UaSrv_MethodOperate.Done THEN
							IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.UaSrv_MethodOperate.IsCalled THEN
								BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.Step := 20; // method is called
							ELSE
								BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.Step := 0; // again
							END_IF
						END_IF
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.UaSrv_MethodOperate.Error THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.LastErrorID := BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.UaSrv_MethodOperate.ErrorID;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.Step := 0;
						END_IF
					END_IF
				20: // execute method code
					FileRead_0(enable := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.Step := 21;
				21:
					FileRead_0.enable := TRUE;
					FileRead_0.ident := BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.fileHandle;
					IF (BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.length > SIZEOF(BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.data)) THEN
						FileRead_0.len := SIZEOF(BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.data);
					ELSE
						FileRead_0.len := BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.length;
					END_IF
					FileRead_0.offset := fiOffset;
					FileRead_0.pDest := ADR(BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.data.Data);
					FileRead_0();
					IF NOT (FileRead_0.status = 65535) THEN
						IF FileRead_0.status = 0 THEN							
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.data.Length := FileRead_0.bytesread;
							fiOffset := fiOffset + FileRead_0.bytesread;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.UaSrv_MethodOperate.MethodResult := 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.Step := 30;
						ELSE							
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.data.Length := 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.UaSrv_MethodOperate.MethodResult := 16#80010000;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.Step := 30;
						END_IF
					END_IF
				30: // finish operate 
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.UaSrv_MethodOperate(Execute := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.Step := 40;
				40: // finish method 
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.UaSrv_MethodOperate(Execute := TRUE,
						Action  := UaMoa_Finished);
					IF NOT BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.UaSrv_MethodOperate.Busy THEN
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.UaSrv_MethodOperate.Done THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.LastErrorID:= 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.Step := 0; // method is finished, wait again for call
						END_IF
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.UaSrv_MethodOperate.Error THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.LastErrorID:= BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.UaSrv_MethodOperate.ErrorID;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Read.Step := 0;
						END_IF
					END_IF
			END_CASE;

			// execute method Write()

			CASE BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.Step OF
				0: // start operate
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.UaSrv_MethodOperate(Execute := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.Step := 10;
				10: // check if method called
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.UaSrv_MethodOperate(Execute := TRUE,
						Action  := UaMoa_CheckIsCalled,
						MethodName := 'File1_Write');
					IF NOT BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.UaSrv_MethodOperate.Busy THEN
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.UaSrv_MethodOperate.Done THEN
							IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.UaSrv_MethodOperate.IsCalled THEN
								BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.Step := 20; // method is called
							ELSE
								BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.Step := 0; // again
							END_IF
						END_IF
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.UaSrv_MethodOperate.Error THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.LastErrorID := BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.UaSrv_MethodOperate.ErrorID;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.Step := 0;
						END_IF
					END_IF
				20: // execute method code
					FileWrite_0(enable := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.Step := 21;
				21:
					FileWrite_0.enable := TRUE;
					FileWrite_0.ident := BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.fileHandle;
					FileWrite_0.len := BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.data.Length;
					FileWrite_0.offset := fiOffset;
					//					FileWrite_0.option := fiTruncate;
					FileWrite_0.pSrc := ADR(BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.data.Data);
					FileWrite_0();
					IF NOT (FileWrite_0.status = 65535) THEN
						IF FileWrite_0.status = 0 THEN
							fiOffset := fiOffset + FileWrite_0.len;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.UaSrv_MethodOperate.MethodResult := 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.Step := 30;
						ELSE
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.UaSrv_MethodOperate.MethodResult := 16#80010000;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.Step := 30;
						END_IF
					END_IF
				30: // finish operate 
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.UaSrv_MethodOperate(Execute := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.Step := 40;
				40: // finish method 
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.UaSrv_MethodOperate(Execute := TRUE,
						Action  := UaMoa_Finished);
					IF NOT BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.UaSrv_MethodOperate.Busy THEN
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.UaSrv_MethodOperate.Done THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.LastErrorID:= 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.Step := 0; // method is finished, wait again for call
						END_IF
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.UaSrv_MethodOperate.Error THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.LastErrorID:= BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.UaSrv_MethodOperate.ErrorID;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Write.Step := 0;
						END_IF
					END_IF
			END_CASE;

			// Execute method GetPosition()

			CASE BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.Step OF
				0: // start operate
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.UaSrv_MethodOperate(Execute := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.Step := 10;
				10: // check if method called
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.UaSrv_MethodOperate(Execute := TRUE,
						Action  := UaMoa_CheckIsCalled,
						MethodName := 'File1_GetPosition');
					IF NOT BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.UaSrv_MethodOperate.Busy THEN
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.UaSrv_MethodOperate.Done THEN
							IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.UaSrv_MethodOperate.IsCalled THEN
								BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.Step := 20; // method is called
							ELSE
								BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.Step := 0; // again
							END_IF
						END_IF
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.UaSrv_MethodOperate.Error THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.LastErrorID := BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.UaSrv_MethodOperate.ErrorID;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.Step := 0;
						END_IF
					END_IF
				20: // execute method code
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.position := fiOffset;
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.UaSrv_MethodOperate.MethodResult := 0;
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.Step := 30;
				30: // finish operate 
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.UaSrv_MethodOperate(Execute := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.Step := 40;
				40: // finish method 
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.UaSrv_MethodOperate(Execute := TRUE,
						Action  := UaMoa_Finished);
					IF NOT BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.UaSrv_MethodOperate.Busy THEN
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.UaSrv_MethodOperate.Done THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.LastErrorID:= 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.Step := 0; // method is finished, wait again for call
						END_IF
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.UaSrv_MethodOperate.Error THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.LastErrorID:= BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.UaSrv_MethodOperate.ErrorID;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.GetPosition.Step := 0;
						END_IF
					END_IF
			END_CASE;

			// execute method SetPosition()

			CASE BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.Step OF
				0: // start operate
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.UaSrv_MethodOperate(Execute := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.Step := 10;
				10: // check if method called
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.UaSrv_MethodOperate(Execute := TRUE,
						Action  := UaMoa_CheckIsCalled,
						MethodName := 'File1_SetPosition');
					IF NOT BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.UaSrv_MethodOperate.Busy THEN
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.UaSrv_MethodOperate.Done THEN
							IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.UaSrv_MethodOperate.IsCalled THEN
								BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.Step := 20; // method is called
							ELSE
								BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.Step := 0; // again
							END_IF
						END_IF
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.UaSrv_MethodOperate.Error THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.LastErrorID := BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.UaSrv_MethodOperate.ErrorID;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.Step := 0;
						END_IF
					END_IF
				20: // execute method code
					fiOffset := BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.position;
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.UaSrv_MethodOperate.MethodResult := 0;
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.Step := 30;
				30: // finish operate 
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.UaSrv_MethodOperate(Execute := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.Step := 40;
				40: // finish method 
					BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.UaSrv_MethodOperate(Execute := TRUE,
						Action  := UaMoa_Finished);
					IF NOT BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.UaSrv_MethodOperate.Busy THEN
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.UaSrv_MethodOperate.Done THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.LastErrorID:= 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.Step := 0; // method is finished, wait again for call
						END_IF
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.UaSrv_MethodOperate.Error THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.LastErrorID:= BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.UaSrv_MethodOperate.ErrorID;
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.SetPosition.Step := 0;
						END_IF
					END_IF
			END_CASE;

			// Execute method CreateFile()

			CASE BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.Step OF
				0: // start operate
					BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.UaSrv_MethodOperate(Execute := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.Step := 10;
				10: // Check if method called
					BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.UaSrv_MethodOperate(Execute := TRUE,
						Action  := UaMoa_CheckIsCalled,
						MethodName := 'Dir1_CreateFile');
					IF NOT BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.UaSrv_MethodOperate.Busy THEN
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.UaSrv_MethodOperate.Done THEN
							IF BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.UaSrv_MethodOperate.IsCalled THEN
								BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.Step := 20; // method is called
							ELSE
								BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.Step := 0; // again
							END_IF
						END_IF
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.UaSrv_MethodOperate.Error THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.LastErrorID := BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.UaSrv_MethodOperate.ErrorID;
							BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.Step := 0;
						END_IF
					END_IF
				20: // execute method code
					FileCreate_0 (enable := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.Step := 21;
				21:
					FileCreate_0(enable := TRUE, pDevice := ADR(BrFileDevices.FileDevice1.Path), pFile := ADR(BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.fileName));
					IF NOT (FileCreate_0.status = 65535) THEN
						IF FileCreate_0.status = 0 THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.fileHandle := FileCreate_0.ident;
							IF BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.requestFileOpen = TRUE THEN
								//BrFileDevices.FileDevice1.FileSystem.Dir1.File1.Size := FileOpen_0.filelen; (Commented Variable)(Calculate length)
								BrFileDevices.FileDevice1.FileSystem.Dir1.File1.OpenCount := BrFileDevices.FileDevice1.FileSystem.Dir1.File1.OpenCount +1;
								BrFileDevices.FileDevice1.FileSystem.Dir1.File1.FileName := BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.fileName;
								fiOffset := 0;
							END_IF
							BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.fileNodeId.NamespaceIndex := NamespaceIndex;
							BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.fileNodeId.IdentifierType := UAIT_Numeric;
							BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.fileNodeId.Identifier := '5005';
							BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.UaSrv_MethodOperate.MethodResult := 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.Step := 30;							
						ELSE
							BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.fileHandle := 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.UaSrv_MethodOperate.MethodResult := 16#80010000;
							BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.Step := 30;							
						END_IF
					END_IF
				30: // finish operate 
					BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.UaSrv_MethodOperate(Execute := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.Step := 40;
				40: // finish method 
					BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.UaSrv_MethodOperate(Execute := TRUE,
						Action  := UaMoa_Finished);
					IF NOT BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.UaSrv_MethodOperate.Busy THEN
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.UaSrv_MethodOperate.Done THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.LastErrorID:= 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.Step := 0; // method is finished, wait again for call
						END_IF
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.UaSrv_MethodOperate.Error THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.LastErrorID:= BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.UaSrv_MethodOperate.ErrorID;
							BrFileDevices.FileDevice1.FileSystem.Dir1.CreateFile.Step := 0;
						END_IF
					END_IF
			END_CASE;

			// execute method Delete()

			CASE BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.Step OF
				0: // start operate
					BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.UaSrv_MethodOperate(Execute := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.Step := 10;
				10: // check if method called
					BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.UaSrv_MethodOperate(Execute := TRUE,
						Action  := UaMoa_CheckIsCalled,
					MethodName := 'Dir1_Delete');
					IF NOT BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.UaSrv_MethodOperate.Busy THEN
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.UaSrv_MethodOperate.Done THEN
							IF BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.UaSrv_MethodOperate.IsCalled THEN
								BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.Step := 20; // method is called
							ELSE
								BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.Step := 0; // again
							END_IF
						END_IF
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.UaSrv_MethodOperate.Error THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.LastErrorID := BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.UaSrv_MethodOperate.ErrorID;
							BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.Step := 0;
						END_IF
					END_IF
				20: // execute method code
					FileDelete_0 (enable := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.Step := 21;
				21:
					FileDelete_0(enable := TRUE, pDevice := ADR(BrFileDevices.FileDevice1.Path), pName := ADR(BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.objectToDelete));
					IF NOT (FileDelete_0.status = 65535) THEN
						IF FileDelete_0.status = 0 THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.File1.OpenCount := BrFileDevices.FileDevice1.FileSystem.Dir1.File1.OpenCount -1;
							fiOffset := 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.UaSrv_MethodOperate.MethodResult := 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.Step := 30;
						ELSE
							BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.UaSrv_MethodOperate.MethodResult := 16#80010000;
							BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.Step := 30;
						END_IF
					END_IF
				30: // finish operate 
					BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.UaSrv_MethodOperate(Execute := FALSE);
					BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.Step := 40;
				40: // finish method 
					BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.UaSrv_MethodOperate(Execute := TRUE,
						Action  := UaMoa_Finished);
					IF NOT BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.UaSrv_MethodOperate.Busy THEN
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.UaSrv_MethodOperate.Done THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.LastErrorID:= 0;
							BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.Step := 0; // method is finished, wait again for call
						END_IF
						IF BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.UaSrv_MethodOperate.Error THEN
							BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.LastErrorID:= BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.UaSrv_MethodOperate.ErrorID;
							BrFileDevices.FileDevice1.FileSystem.Dir1.Delete.Step := 0;
						END_IF
					END_IF
			END_CASE;

	END_CASE;
	Status := Step;
	DemoVariable := 1;
END_FUNCTION_BLOCK
