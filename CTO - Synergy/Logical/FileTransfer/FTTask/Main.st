
PROGRAM _INIT

	FileSystem (Execute := FALSE);

	FileDevices.FileDeviceCount := 1;
	FileDevices.FileDevice1.Path :=	'UaFiles';
	FileDevices.FileDevice1.DeviceType := Fixed_0;
	FileDevices.FileDevice1.VendorName := 'BR';
	FileDevices.FileDevice1.FileSystem.Dir1.DirectoryName := 'Dir1';
	FileDevices.FileDevice1.FileSystem.Dir1.File1.FileName := 'page1.jpg';

END_PROGRAM

PROGRAM _CYCLIC
	
	IF FileSystem.Execute = FALSE THEN
		FileSystem.Execute := TRUE;							// eneable execution of function block
	END_IF
	FileSystem.BrFileDevices := ADR(FileDevices);			// pointer to filedevices structure
	FileSystem ();											// call file system function block
	
END_PROGRAM

PROGRAM _EXIT

	 
END_PROGRAM

