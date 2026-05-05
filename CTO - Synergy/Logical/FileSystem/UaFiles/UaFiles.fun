
FUNCTION_BLOCK UaFileSystem (* file system interface *)
	VAR_INPUT
		Execute : BOOL;
		BrFileDevices : REFERENCE TO UaBrFileDevicesType;
	END_VAR
	VAR_OUTPUT
		Status : DINT;
	END_VAR
	VAR
		Step : INT;
		NamespaceIndex : UINT;
		NamespaceIndexs : STRING[8];
		UaSrv_GetNamespaceIndex_0 : UaSrv_GetNamespaceIndex;
		ErrorID : DWORD;
		FileOpen_0 : FileOpen;
		FileClose_0 : FileClose;
		FileRead_0 : FileReadEx;
		FileWrite_0 : FileWriteEx;
		FileCreate_0 : FileCreate;
		FileDelete_0 : FileDelete;
		fiMode : USINT;
		fiOffset : UDINT;
	END_VAR
	VAR CONSTANT
		NamespaceUri : STRING[80] := 'http://br-automation.com/OpcUa/FileTransfer/';
	END_VAR
END_FUNCTION_BLOCK
