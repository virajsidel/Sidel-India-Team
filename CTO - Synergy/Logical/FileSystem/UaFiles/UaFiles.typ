
TYPE
	UaBrFileDevicesType : 	STRUCT 
		FileDeviceCount : UDINT;
		FileDevice1 : UaBrFileDeviceType;
	END_STRUCT;
	UaBrFileDeviceType : 	STRUCT 
		DeviceType : UaBrFileDeviceTypesEnumeration;
		Free : UDINT;
		Label : STRING[80];
		Path : STRING[80];
		SerialNumber : STRING[80];
		Size : UDINT;
		VendorName : STRING[80];
		FileSystem : UaBrStaticFileDirectoryType;
	END_STRUCT;
	UaBrFileDeviceTypesEnumeration : 
		(
		Fixed_0 := 0,
		Removable_1 := 1,
		Network_2 := 2
		);
	UaBrStaticFileDirectoryType : 	STRUCT 
		DirectoryName : STRING[80];
		CreateDirectory : UaCreateDirectoryMethodType;
		CreateFile : UaCreateFileMethodType;
		Delete : UaDeleteMethodType;
		MoveOrCopy : UaMoveOrCopyMethodType;
		Dir1 : UaBrStaticFileDir1Type;
	END_STRUCT;
	UaBrStaticFileDir1Type : 	STRUCT 
		DirectoryName : STRING[80];
		CreateDirectory : UaCreateDirectoryMethodType;
		CreateFile : UaCreateFileMethodType;
		Delete : UaDeleteMethodType;
		MoveOrCopy : UaMoveOrCopyMethodType;
		File1 : UaBrStaticFileType;
	END_STRUCT;
	UaBrStaticFileType : 	STRUCT 
		FileName : STRING[80];
		IsOpenExclusive : BOOL;
		OpenExclusive : UaOpenExclusiveMethodType;
		CreationTime : DATE_AND_TIME;
		LastAccessTime : DATE_AND_TIME;
		LastWriteTime : DATE_AND_TIME;
		Size : UDINT;
		Writable : BOOL;
		UserWritable : BOOL;
		OpenCount : UINT;
		MimeType : STRING[80];
		Open : UaOpenMethodType;
		Close : UaCloseMethodType;
		Write : UaWriteMethodType;
		Read : UaReadMethodType;
		GetPosition : UaGetPositionMethodType;
		SetPosition : UaSetPositionMethodType;
	END_STRUCT;
	BrUaByteStringFile : 	STRUCT  (* Big Byte string containing length and data	*)
		Length : DINT;
		Data : ARRAY[0..50000]OF USINT;
	END_STRUCT;
	UaCloseMethodType : 	STRUCT 
		Step : INT;
		LastErrorID : DWORD;
		MethodName : STRING[80];
		UaSrv_MethodOperate : UaSrv_MethodOperate;
		fileHandle : UDINT;
	END_STRUCT;
	UaCreateDirectoryMethodType : 	STRUCT 
		Step : INT;
		LastErrorID : DWORD;
		MethodName : STRING[80];
		UaSrv_MethodOperate : UaSrv_MethodOperate;
		directoryName : STRING[80];
		directoryNodeId : UANodeID;
	END_STRUCT;
	UaCreateFileMethodType : 	STRUCT 
		Step : INT;
		LastErrorID : DWORD;
		MethodName : STRING[80];
		UaSrv_MethodOperate : UaSrv_MethodOperate;
		fileName : STRING[80];
		requestFileOpen : BOOL;
		fileNodeId : UANodeID;
		fileHandle : UDINT;
	END_STRUCT;
	UaDeleteMethodType : 	STRUCT 
		Step : INT;
		LastErrorID : DWORD;
		MethodName : STRING[80];
		UaSrv_MethodOperate : UaSrv_MethodOperate;
		objectToDelete : UANodeID;
	END_STRUCT;
	UaGetPositionMethodType : 	STRUCT 
		Step : INT;
		LastErrorID : DWORD;
		MethodName : STRING[80];
		UaSrv_MethodOperate : UaSrv_MethodOperate;
		fileHandle : UDINT;
		position : UDINT;
	END_STRUCT;
	UaMoveOrCopyMethodType : 	STRUCT 
		Step : INT;
		LastErrorID : DWORD;
		MethodName : STRING[80];
		UaSrv_MethodOperate : UaSrv_MethodOperate;
		objectToMoveOrCopy : UANodeID;
		targetDirectory : UANodeID;
		createCopy : BOOL;
		newName : STRING[80];
		newNodeId : UANodeID;
	END_STRUCT;
	UaOpenExclusiveMethodType : 	STRUCT 
		Step : INT;
		LastErrorID : DWORD;
		MethodName : STRING[80];
		UaSrv_MethodOperate : UaSrv_MethodOperate;
		mode : BYTE;
		fileHandle : UDINT;
	END_STRUCT;
	UaOpenMethodType : 	STRUCT 
		Step : INT;
		LastErrorID : DWORD;
		MethodName : STRING[80];
		UaSrv_MethodOperate : UaSrv_MethodOperate;
		mode : BYTE;
		fileHandle : UDINT;
	END_STRUCT;
	UaReadMethodType : 	STRUCT 
		Step : INT;
		LastErrorID : DWORD;
		MethodName : STRING[80];
		UaSrv_MethodOperate : UaSrv_MethodOperate;
		fileHandle : UDINT;
		length : DINT;
		data : BrUaByteStringFile;
	END_STRUCT;
	UaSetPositionMethodType : 	STRUCT 
		Step : INT;
		LastErrorID : DWORD;
		MethodName : STRING[80];
		UaSrv_MethodOperate : UaSrv_MethodOperate;
		fileHandle : UDINT;
		position : UDINT;
	END_STRUCT;
	UaWriteMethodType : 	STRUCT 
		Step : INT;
		LastErrorID : DWORD;
		MethodName : STRING[80];
		UaSrv_MethodOperate : UaSrv_MethodOperate;
		fileHandle : UDINT;
		data : BrUaByteStringFile;
	END_STRUCT;
END_TYPE
