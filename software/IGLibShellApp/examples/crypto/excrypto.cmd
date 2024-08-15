
C *********************************************
C Examples: Cryptographic utilities
C *********************************************

C C This file contains example commands for the IGLib cryptographic 
C C utilities. In order to run the examples, you need IgShell or HashShell:
C C http://www2.arnes.si/~ljc3m2/igor/software/IGLibShellApp/
C C http://www2.arnes.si/~ljc3m2/igor/software/IGLibShellApp/HashForm.html

C C Run the IGLib shell application (e.g. igs.exe) with commandline arguments
C C Copied from this file!
C C You can also uncomment some lines and interpret this file. In order
C C to do this, run the application with Run as the first argument and
C C name of tis file as the second argument, i.e.
C C 
C C   igs.exe Run excrypto.cmd
C C 
C C Command names are NOT CASE SENSITIVE in most shell applications.
C C Lines commented by a SINGLE C can be executed in the shell, while lines
C C commented by double C are just comments.

C C Print help on group of embedded applications or single app.:
C Internal IG.Script.AppBase Crypto ?
C Internal IG.Script.AppBase Crypto GetFileHash ?

WriteLine "When running this file, uncomment the lines that you want to execte!"


C C ****************************************************************************
C C CALCULATION and verification OF HASH VALUES (CHECKSUMS)

C C ==================
C C HashForm:
C C Launch a form for calculation and verification of file and text
C C hash functions (checksums - MD5, SHA-1, SHA-256, SHA-512):
C C ====

C C == Examples:
C Internal IG.Script.AppExtBase Crypto HashForm

C C ==================
C C GetFileHash:
C C Calculate FILE HASHes for the specified file, eventually write information
C C to a file (last argument):

C C Internal IG.Script.AppBase Crypto GetFileHash FilePath <WriteToFile> <HashFileName> 
C C   WriteToFile: whether hash values are written to a file, default is false
C C   HashFileName: name of the file where hash values are written. If not
C C     specified then it is specified by adding ".chk" to the hash file
C C ====

C C == Examples:
C Internal IG.Script.AppBase Crypto GetFileHash excrypto.cmd true excrypto.cmd.chk


C C ==================
C C CheckSum:
C C Calculates / verify hashes of files or strings by the CheckSum command:

C C CheckSum <-c> <-s> <-h hash> <-t hashType> <-o outputFile> <inputFile1> <inputFile2> ...: 
C C   Calculates or verifies various types of hash values for files or strings. Calculated file hashes
C C   can be saved to a file.
C C     -t hashType: specifies hash type (MD5, SHA-1, SHA-256, SHA-512)
C C     -c: verification rather than calculation of hashes.
C C     -s: hash is calculated or verified for the specified strings rather than files.
C C     -h hash: hash value to be verified.
C C     -o outputFile: output file where calculated hashes are written. Should
C C       be in the current directory, otherwise checking may not work correctly.
C C     - inputFile1 inputFile2 ...: input files, either files whose hashes are calculated, or files
C C       containing hash values to be verified (in the case of -c option)
C C A number of other parameters are supported:
C C     -rd dir: input files will be recursively searched for in the directory
C C       named dir. Several directories for recursive file search can be
C C       specified, each following its own -rd option.
C C     - rdl dir: similar to -rd, but order of file listing is by directory
C C       levels rather than in normal tree traversal.
C C     -rp ptrn: specifies that files that match the specified pattern
C C       ptrn will be searched in a recursive search. Patterns can contain
C C       wildcards (e.g. "*.cmd" or "a*.txt"). Several patterns can be 
C C       specified (each one by its own -rp option) in which case all are
C C       used with all recursive directories.
C C     -rl dirLevel: specifies the level of directories for recursive search.
C C       -1 means all levels of subdirectories are searched, 0 means none
C C     -pa: specifies that file pathss are output as absolute.
C C     -pr: specifies that file paths are output as relative paths.
C C     -yo: specifies that files will be automatically overwritten, withot
C C       asking the user. This is useful in batch executon.
C C     -no: specifies that no files are overwritten. In all possibilities
C C       of overwriting a file, the operaton is automatically skipped 
C C       without asking a user (meaning that some information may be lost)
C C These options give an excellent flexibility, e.g. one can iterates over
C C all files of a directory recursively and store their hashes in the 
C C specified output file for later verification (all by a single command).
C C ====

C C == Examples:
C C Calculate MD5 checksums of several files & store them to hashes.MD5:
C Internal IG.Script.AppBase Crypto CheckSum -t MD5 -o hashes.MD5 0readme_crypto.txt excrypto.cmd 

C C Verify previously calculated checksums (first command generates them):
C Internal IG.Script.AppBase Crypto CheckSum -t MD5 -o hashes.MD5 0readme_crypto.txt excrypto.cmd 
C Internal IG.Script.AppBase Crypto CheckSum -t MD5 -c hashes.MD5 

C C Calculate & verify other kind of checksum (e.g. SHA-1, SHA-256, SHA-512):
C Internal IG.Script.AppBase Crypto CheckSum -t SHA-256 -o hashes.SHA256 *.cmd *.txt
C Internal IG.Script.AppBase Crypto CheckSum -t SHA-256 -c hashes.SHA256

C C Calculate hash for a single file (without writing to a file): 
C Internal IG.Script.AppBase Crypto CheckSum -t SHA-1 excrypto.cmd 
C C - or for multiple files: 
C Internal IG.Script.AppBase Crypto CheckSum -t SHA-1 *.cmd *.txt cryptofiles/*

C C Recursively calculate hashes for all files in a directory, store them to
C C a file, and later verify them:
C Internal IG.Script.AppBase Crypto CheckSum -t SHA-1 -rd ./ -o hashes.SHA1 -no 
C Internal IG.Script.AppBase Crypto CheckSum -t SHA-1 -rd ./cryptofiles -o hashes2.SHA1 -no 
C C Note the -no option, meaning that ouptu files that already exist will be
C C automatically skipped and are not overwritten. With the -yo option, the 
C C opposite is achieved and files are automatically overwritten.
C C - Afterwards, check consistency at later times (note use of wildcards):
C Internal IG.Script.AppBase Crypto CheckSum -t SHA-1 -c *.SHA1
C C If any file at any location in the observed directories would change at
C C a later time, this would be immediately noticed by the check.

C C Search patterns with wildcards can be specified to filter files in 
C C recursive directory listings: 
C Internal IG.Script.AppBase Crypto CheckSum -t MD5 -rd ./ -rp *.txt -rp *.cmd 
C Internal IG.Script.AppBase Crypto CheckSum -t MD5 -rd ./ -rp *1.1*.txt -rp *.cmd 

C C Direct verification of specified hash value of a file
C Internal IG.Script.AppBase Crypto CheckSum -t MD5 -c data1.txt -h 7ad479880f6f78223e93791d2cce600d 
C C If the result was negative, replace the checksum following the -h option
C C with the checksumm produced by the following command:
C Internal IG.Script.AppBase Crypto CheckSum -t MD5 data1.txt

C C Calculation of hashes of various types of the string "My String":
C C MD5 = 4545102cc40ea0a85124cf4b31574661
C C SHA1 = 07841b2e0fda6cfbf7c6bf00f179233cf4e3247b
C C SHA256 = 8a7046a0b97e45470b13f30448c9d7d959aa5eea583d2f007921736b2141ac75
C C SHA512 = d159694d78c06886143e08dadc50cb89a96a41c766b603fa07fe3de91e170bf2942545c1ca17e280f572fc829de6059a80e75f4623e736915265f8938bb19e39
C Internal IG.Script.AppBase Crypto CheckSum -s -t MD5 "My String"
C Internal IG.Script.AppBase Crypto CheckSum -s -t SHA1 "My String"
C Internal IG.Script.AppBase Crypto CheckSum -s -t SHA256 "My String"
C Internal IG.Script.AppBase Crypto CheckSum -s -t SHA512 "My String"

C C Verification of a string hash value (change hash to make it not pass):
C Internal IG.Script.AppBase Crypto CheckSum -t MD5 -c -s "My String" -h 4545102cc40ea0a85124cf4b31574661
C Internal IG.Script.AppBase Crypto CheckSum -t SHA256 -c -s "My String" -h 8a7046a0b97e45470b13f30448c9d7d959aa5eea583d2f007921736b2141ac75

C C Hashes can also be calculated for multiple strings and byte arrays
C C specified in hexadecimal or base-64 encoding (also use -s option for
C C this purpose, and specify formats via -bfi* or -bf* options):
C Internal IG.Script.AppBase Crypto Convert Luxembourg
C Internal IG.Script.AppBase Crypto CheckSum -s -t MD5 -bfii 23 55 685
C Internal IG.Script.AppBase Crypto CheckSum -s -t MD5 Str1 Str2 Luxembourg
C Internal IG.Script.AppBase Crypto CheckSum -s -t MD5 -bfix 4c-75-78-65-6d-62-6f-75-72-67
C Internal IG.Script.AppBase Crypto CheckSum -s -t MD5 -bfi64 THV4ZW1ib3VyZw==

C C Hashes for byte arrays or long integers can aldo be verified:
C Internal IG.Script.AppBase Crypto CheckSum -c -s -t MD5 -bfi64 THV4ZW1ib3VyZw== -h 06630c890abadde9228ea818ce52b621 
C Internal IG.Script.AppBase Crypto CheckSum -c -s -t MD5 -bfix 4c-75-78-65-6d-62-6f-75-72-67 -h 06630c890abadde9228ea818ce52b621 

C C ==== END: CheckSum


C C ==================
C C COMMENTS on OVERWRITE/DELETE CONFIRMATIONS
C C Some operations may overwrite or delete a number of files. In such cases,
C C the default behavior is to ask the user for confirmations to overwrite 
C C or delete each individual file. Usually, after the first confirmation or
C C rejection, the user is asked whether the decision shoulld be applied to
C C all further files that would be overwritten/deleted.
C C To the questions that require a "yes" or "no" answer, user can answer
C C with "1", "y", "yes" or "true" to confirm and with "0", "n", "no" or 
C C "false" to reject the operation. Sometimes, any nonzero number will be
C C considered as yes. Pressing <Enter> will accept the default decision. 
C C Inserting a queston mark ("?") will print short instructions and the
C C current (default) value of the answer (taken when <Enter> is pressed).


C C ****************************************************************************
C C SYMMETRIC ENCRYPTION


C C ==================
C C EncryptPlain, DecryptPlain:
C C Encrypt or decrypt files, strings, and byte values by using symmetric-key
C C algorithms. This is a plain variant where user directly provides the key,
C C initializaton vector, and other parameters for encryption. Therefore, this
C C class of functions is more difficult to use and is also less safe for 
C C non-expert users,but enables more fine tunning options for advanced users.
C C Encrypt and decrypt use the same sets of parameters.

C C Internal IG.Script.AppBase Crypto Encrypt input <-k key> <-sl salt> 
        <-iv IV> <-t algorithm> <-o outputFile>
C C   Encrypts input (which can be a string, byte field, or a set of files)
C C     by using the specified symmetric-key algorithm.
C C Parameters:
C C   input: an item (or a set of items) to be encrypted. This can be strings,
C C     byte arrays, or files, dependent on other parameters.
C C   -t algorithm: type of the symmetric-key algorithm used. 
C C     Default is RD or Rijndael(the Rijndael algorithm, part of which is ued 
C C     in the Advanced Encryption Standard - AES), and others include AES (the
C C     previously mentioned algorithm from the standard, a subser of RD),
C C     TD or TripleDes, DES, and RC2.
C C   -k key: specifies the SECRET key used for encryption. Key must be kept
C C     secret in a carefully guarded safe store, and only transferred in
C C     encrypted form between parties in communication (typically enxrypted
C C     by a puclic-key algorithm)
C C   -iv IV: specifies the initialization vector used for encryption. IV
C C     can be kept secret, but this is not a requirement. Specification of 
C C     IV is a request of symmetric algorithms, and the same key must be used
C C     in decryption. The best practice is to randomly generate IV for each
C C     session or each group of encrypted items.
C C   -sl salt: Salt, a part that is added to the encrypted test before 
C C     encryption. This makes more difficult for potential attackers to guess the 
C C     original text or secret parameters (such as keys and passwords), even
C C     if they are able to intercept messages and know the original and 
C C     decrypted text in some cases.
C C   -o outputFile: when specified, the encrypted text (or a file) is stored
C C     to the file defined by outputFile (which must be a valid file path).
C C A number of other parameters are supported:
C C     - pw password: password used for encryption, specified as string. If 
C C       key is not provided then the password is used in place of the key.
C C     -pwx password: binary password specified in hexadecimal format.
C C       "3dca9a", "3DCA9A", "3dCa9a", "3D-ca-9a" are all accepted.
C C     -bw64 password: binary password specified in base64 encoding
C C     -sl salt: salt specified as string.
C C     -slx salt: binary salt in hexadecimal format.
C C     -sl64 salt: binary salt specified in base-64 encoding.
C C     -bfx: Result (envrypted text) will be returned as hexadecimal string 
C C       representation of the generated byte array.
C C     -bf64: Result (generated text) will be returned in as base-64 encoded 
C C       string representation of the generated byte array.
C C 
C C     -rd dir: input files will be recursively searched for in the directory
C C       named dir. Several directories for recursive file search can be
C C       specified, each following its own -rd option.
C C     - rdl dir: similar to -rd, but order of file listing is by directory
C C       levels rather than in normal tree traversal.
C C     -rp pttrn: specifies that files that match the specified pattern
C C       ptrn will be searched in a recursive search. Patterns can contain
C C       wildcards (e.g. "*.cmd" or "a*.txt"). Several patterns can be 
C C       specified (each one by its own -rp option) in which case all are
C C       used with all recursive directories.
C C     -rl dirLevel: specifies the level of directories for recursive search.
C C       -1 means all levels of subdirectories are searched, 0 means none
C C     -pa: specifies that file pathss are output as absolute.
C C     -pr: specifies that file paths are output as relative paths.
C C     -yo: specifies that files will be automatically overwritten, withot
C C       asking the user. This is useful in batch executon.
C C     -no: specifies that no files are overwritten. In all possibilities
C C       of overwriting a file, the operaton is automatically skipped 
C C       without asking a user (meaning that some information may be lost)
C C ====

C C == Examples:

C C == Encrypt / decrypt STRINGS:

C C Encrypt a number of strings (the -s option), with password (-pw) and 
C C initialization vector (-iv) provided in string form:
C Internal IG.Script.AppBase Crypto EncryptPlain -s -pw MyPassword11 -iv MyInitializationVector "Encrypted string No. 1"  "Encrypted string No. 2"

C C Decrypt the results in order to restore original strings:
C Internal IG.Script.AppBase Crypto DecryptPlain -s -pw MyPassword11 -iv MyInitializationVector  dggQxTn7y2m2tDw44rR/oU4ffveVClIsO/chAo5TT30=  dggQxTn7y2m2tDw44rR/oYfhlHfVt6j1Ug0f8UYI2fM=

C C If password or initialization vector is not specified then you will be 
C C asked to insert them (below, insert "MyPassword1"):
C Internal IG.Script.AppBase Crypto EncryptPlain -s -iv MyInitializationVector "Encrypted string No. 1"  "Encrypted string No. 2"
C Internal IG.Script.AppBase Crypto DecryptPlain -s -iv MyInitializationVector  AWeIDmTh2PkCda9RJ0lpyVCtcrfyMyGxaXt4xHyhP4E= AWeIDmTh2PkCda9RJ0lpyUFaxm8P6So2hjJ/aBvOV6k=

C C You can try to insert password in hexadecimal form or in base-64. In the
C C above examples, password in string form is "MyPassword1", which corresponds
C C to 4d-79-50-61-73-73-77-6f-72-64-31 in hexadecimal form or to 
C C TXlQYXNzd29yZDE= in base-64 encoding. Try to insert it in both form (first,
C C selsect binary form, then one of two encodings):
C Internal IG.Script.AppBase Crypto EncryptPlain -s -iv MyInitializationVector "Encrypted string No. 1"  "Encrypted string No. 2"
C Internal IG.Script.AppBase Crypto DecryptPlain -s -iv MyInitializationVector  AWeIDmTh2PkCda9RJ0lpyVCtcrfyMyGxaXt4xHyhP4E= AWeIDmTh2PkCda9RJ0lpyUFaxm8P6So2hjJ/aBvOV6k=

C C We could see above that encryption of two similar strings produces two 
C C similar outputs. This is because the same initialization vectors are used 
C C and no salt. In real life situations, this can be exploited to guess the
C C original messages and sometimes even the passwords (which means that
C C all intercepted text can be decrypted). Therefore it is important to
C C use randomly generated initialization vectors and salts within encryption 
C C process. Keys should also be generated from passwords with proper 
C C cryptographic algorithms.

C C Beside the password and initialization vector, we can specify the salt,
C C which is added to the text before encryption. Now results are longer,
C C and on deryption side we also need to specifiy the original salt value:
C Internal IG.Script.AppBase Crypto EncryptPlain -s -sl MyTestSalt1 -pw MyPassword11 -iv MyInitializationVector "Encrypted string No. 1"
C Internal IG.Script.AppBase Crypto DecryptPlain -s -sl MyTestSalt1 -pw MyPassword11 -iv MyInitializationVector  sZj+d0FH/bURmo9s39BY1j0zCn2LeUT1F7mktz9VpH6W69w9D80gT3hSaTS+Gu0y

C C On decryption side, we can provide only the length of the salt, rather 
C C than its content (which is 11 bytes, written out by encryption part):
C Internal IG.Script.AppBase Crypto DecryptPlain -s -sllen 11 -pw MyPassword11 -iv MyInitializationVector  sZj+d0FH/bURmo9s39BY1j0zCn2LeUT1F7mktz9VpH6W69w9D80gT3hSaTS+Gu0y
C C If we input the wrong salt length or do not input it, then the decrypted
C C string will contain parts of the salt or will be truncated:
C Internal IG.Script.AppBase Crypto DecryptPlain -s -sllen 8 -pw MyPassword11 -iv MyInitializationVector  sZj+d0FH/bURmo9s39BY1j0zCn2LeUT1F7mktz9VpH6W69w9D80gT3hSaTS+Gu0y
C Internal IG.Script.AppBase Crypto DecryptPlain -s -sllen 17 -pw MyPassword11 -iv MyInitializationVector  sZj+d0FH/bURmo9s39BY1j0zCn2LeUT1F7mktz9VpH6W69w9D80gT3hSaTS+Gu0y
C Internal IG.Script.AppBase Crypto DecryptPlain -s -pw MyPassword11 -iv MyInitializationVector  sZj+d0FH/bURmo9s39BY1j0zCn2LeUT1F7mktz9VpH6W69w9D80gT3hSaTS+Gu0y

C C Byte arrays to be encrypted and decrypted can be inserted in 
C C hexadecimal format (by use of the -bfix option) or in base-64 encoding
C C (the -bfi64 option). In order to test this, let us first convert some 
C C string to a byte array represented in hexadecimal or base-64 form:
C Internal IG.Script.AppBase Crypto Convert "Encrypted string No. 1"
C C Now encrypt/decrypt binary equivalent (i.e. byte array obtained form 
C C the string) specified in hexadecimal and base-64 form:
C Internal IG.Script.AppBase Crypto EncryptPlain -s -bfix -bfx -pw MyPassword11 -iv MyInitializationVector  456e6372797074656420737472696e67204e6f2e2031
C Internal IG.Script.AppBase Crypto DecryptPlain -s -bfix -bfx -pw MyPassword11 -iv MyInitializationVector  760810c539fbcb69b6b43c38e2b47fa14e1f7ef7950a522c3bf721028e534f7d 
C Internal IG.Script.AppBase Crypto EncryptPlain -s -bfi64 -bf64 -pw MyPassword11 -iv MyInitializationVector  RW5jcnlwdGVkIHN0cmluZyBOby4gMQ==
C Internal IG.Script.AppBase Crypto DecryptPlain -s -bfi64 -bf64 -pw MyPassword11 -iv MyInitializationVector  dggQxTn7y2m2tDw44rR/oU4ffveVClIsO/chAo5TT30= 

C C You can input bytes to be encrypted in one format, and output encrypted
C C bytes in another format. When decryption is made, input and utput 
C C formats are swapped:
C Internal IG.Script.AppBase Crypto EncryptPlain -s -bfix -bf64 -pw MyPassword11 -iv MyInitializationVector  456e6372797074656420737472696e67204e6f2e2031
C Internal IG.Script.AppBase Crypto DecryptPlain -s -bfi64 -bfx -pw MyPassword11 -iv MyInitializationVector  dggQxTn7y2m2tDw44rR/oU4ffveVClIsO/chAo5TT30=


C C == Encrypt / decrypt FILES:

C C Encrypt the specified file and save decrypted content to the specified 
C C file:
C Internal IG.Script.AppBase Crypto EncryptPlain -o 0readme_crypto.txt.encrypted 0readme_crypto.txt -pw MyPassword11 -iv MyInitializationVector 
C C Then decrypt the encrypted file to another file:
C Internal IG.Script.AppBase Crypto DecryptPlain -o 0readme_crypto.txt.decrypted 0readme_crypto.txt.encrypted -pw MyPassword11 -iv MyInitializationVector

C C The -o parameter for specifying the output file can only be used when
C C a single file is encrypted. Without this parameter, paths to the output
C C files are constructed by appending the file extension ".ig_enc"
C C to encrypted files, and ".ig_dec" to decrypted files. In this way, the 
C C original files are not deleted after the operation:
C Internal IG.Script.AppBase Crypto EncryptPlain 0readme_crypto.txt -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto DecryptPlain 0readme_crypto.txt.ig_enc -pw MyPassword11 -iv MyInitializationVector 

C C You can encrypt and decrypt multiple files:
C Internal IG.Script.AppBase Crypto EncryptPlain cryptofiles/*.txt -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto DecryptPlain cryptofiles/*.ig_enc -pw MyPassword11 -iv MyInitializationVector 

C C If you repeat one of the above two commands, yu will be asked for every
C C generated file whether you want to overwrite it. You can skip this by 
C C specifying either the -no to automatically skip overwriting the files, or
C C -yo to automatically overwrite any existent files: 
C Internal IG.Script.AppBase Crypto EncryptPlain -yo cryptofiles/*.txt -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto EncryptPlain -no cryptofiles/*.txt -pw MyPassword11 -iv MyInitializationVector 

C C WARNING: Be extremely  cautious with using automatic overwrites. In 
C C particular you should well test the functionality with every new version 
C C of the software to make sure this behaves as expected and that you are 
C C able to restore files later.

C C While encrypting files without specifying the output file, encrypted files 
C C with distinctive extensions  ".ig_enc" (denoting encrypted contents) 
C C and "ig_dec" (denoting decrypted contents) are skipped. These files can
C C only be encrypted by explicitly specifying the output file with the -o 
C C command-line parameter (which works only for one file at a time).
C C While decrypting, only files with distinctive extension ".ig_dec" are
C C processed. If you want to perform decryption on an arbitrary file,
C C you should use the -o option to explicitly specify the output file.
C C Repeat a pair of encryption / decryption operations twice to see how this 
C C feature works:
C Internal IG.Script.AppBase Crypto EncryptPlain -yo cryptofiles/*.* -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto DecryptPlain -yo cryptofiles/*.* -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto EncryptPlain -yo cryptofiles/*.* -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto DecryptPlain -yo cryptofiles/*.* -pw MyPassword11 -iv MyInitializationVector 

C C In the above commands, the -yo option was used to automatically confirm
C C overwriting the files (in the opposite, you would be requested to confirm
C C overwriting eventually existent files).

C C Encrypted files are decorated by the distinctive ".ig_enc" extension
C C (while not using the -o option to explicitlz specify the output file),
C C and decrypted files get this extension removed and are decorated by
C C the "ig_dec" extension. The original file is NOT affected when 
C C encrypting / decrypting.
C C For example, encryption of "readme.txt" will produce "readme.txt.ig_enc",
C C and decryption will produce "readme.txt.ig_enc", with the original file
C C "readme.txt" left intact.

C C Above can be changed by using the -delorig option. This causes deletion of 
C C the original files after they are encrypted, and decryption does not
C C decorate output file names with a distinctive extension, causing that 
C C the decrypted files have the same names as the originals (also the file 
C C with encrypted contents is removed after decryption):
C Internal IG.Script.AppBase Crypto EncryptPlain -delorig -yd -yo cryptofiles/*.* -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto DecryptPlain -delorig -yd -yo cryptofiles/*.* -pw MyPassword11 -iv MyInitializationVector 

C C WARNING: Be extremely  cautious with using the -delorig option.
C C Use this only when you are sure that wou will be able to restore the 
C C original files. 
C C For this, you must be sure that encrypted/decrypted originals exist from
C C which restore can be achieved, that you know the correct encryption or
C C decryption options, and that you are able to run the correct encryption
C C or decryption algorithm that will restore the originals.
C C The latter means (among the others) that you have tested enough the 
C C algorithm with similar parameters, and you are sure the algorithm
C C works as you expect.
C C In many cases, it is advisable that when encrypting files, bakcup of the
C C originals is kept somewhere (in case you forget the password or some
C C other inpredictable situation appears that would prevent restoring the
C C files from encrypted copies).

C C The CleanFiles command can be used to clean the eventual redundant files
C C that remained after performing encryption or decryption operations. Using
C C this command can be an alternative to the -delorig option, which causes
C C automatic deletion of originals.
C Internal IG.Script.AppBase Crypto EncryptPlain -yo cryptofiles/*.* -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto DecryptPlain -yo cryptofiles/*.* -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto CleanFiles -deldecrypted cryptofiles/*.*

C C Options for RECURSIVE DIRECTORY listing can be used to encrypt or decrypt
C C all files (possibly satisfying one or more name patterns with wildcards)
C C from the given directories and its nested subdirectories (all or up to 
C C the specified level). The command below will encrypt all files with the 
C C ".txt" extension in the "cryptofiles" directoriy and all its nested
C C subdirectories. Afterwards, the created files are deleted by using the
C C CleanFiles command.
C Internal IG.Script.AppBase Crypto EncryptPlain -yo -rd cryptofiles/ -rp *.txt -yo -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto CleanFiles -yd -deldecrypted -delencrypted -rd cryptofiles/ -rp *.*

C C Recursive listing of files only up to the specified level can be used, 
C C the level being specified by the -rl option. In the example below, all 
C C files with the ".txt" extension, contained in the  "cryptofiles" 
C C directoriy and its nested subdirectories up to the second level, are
C C encrypted. With the second command, created files are deleted: 
C Internal IG.Script.AppBase Crypto EncryptPlain -yo -rl 2 -rd cryptofiles/ -rp *.txt -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto CleanFiles -yd  -rl 2 -rd cryptofiles/ -rp *.txt -deldecrypted -delencrypted 

C C In a rather typical scenario, one would want to encrypt all files the 
C C specific directory (possibly in multiple directories and satisfying some
C C wildcard-based filters), check if everything went as expected, and then 
C C delete the originals. At a later time, one might want to decrypt the 
C C files to restore the original state of the directory.
C C In the line below we will do this following these steps:
C C   - encrypt all the files in the directory and all ist nested 
C C     subdirectories, store them beside originals (which are kept intact).
C C   - decrypt the encrypted files and store themm beside the originals, so 
C C     that the results can be checked.
C C   - verify the results by browsing through the directory structure and
C C     compare some original/decrypted pairs (decrypted having the .ig_dec
C C     extension).
C C   - delete the originals and decrypted files to keep only encrypted ones
C C   - at a later time, decrypt the encrypted files to produce the originals,
C C     and simulltaneously delete the input (encrypted) files to keep only
C C     the decrypted originals.
C C Lines below will perform the above steps one by one:
C C -Encrypt all files in the directory and its subdirectories (recursive):
C Internal IG.Script.AppBase Crypto EncryptPlain -yo -rd cryptofiles/ -rp *.* -pw MyPassword11 -iv MyInitializationVector 
C C -Decrypt (for test) the encrypted files and store decrypted files beside
C C the decripted files and originals. After the operation, the directory 
C C structure can be browsed and decrypted files compared with originals:
C Internal IG.Script.AppBase Crypto DecryptPlain -yo -rd cryptofiles/ -rp *.* -pw MyPassword11 -iv MyInitializationVector 
C C -Clean the directory - delete the original and decrypted files in order
C C to keep only the encrypted files:
C Internal IG.Script.AppBase Crypto CleanFiles -yd -delorig -deldecrypted -rd cryptofiles/ -rp *.*
C C -At a later time, decrypt the encrypted file to restore the originals. In
C C this case, we will automatically delete the encrypted files after the
C C operation (by the -delorig option), but we could also leave the encrypted
C C versions (e.g. by not specifying the -yd option and then not confirming
C the deletions), inspect the results and delete the encrypted versions later
C C by calling the CleanFiles command:
C Internal IG.Script.AppBase Crypto DecryptPlain -delorig -yd -rd cryptofiles/ -rp *.* -pw MyPassword11 -iv MyInitializationVector 

C C Below, we just repeat all the above steps without commenting them:
C Internal IG.Script.AppBase Crypto EncryptPlain -yo -rd cryptofiles/ -rp *.* -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto DecryptPlain -yo -rd cryptofiles/ -rp *.* -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto CleanFiles -yd -delorig -deldecrypted -rd cryptofiles/ -rp *.*
C Internal IG.Script.AppBase Crypto DecryptPlain -delorig -yd -rd cryptofiles/ -rp *.* -pw MyPassword11 -iv MyInitializationVector 


C C ==== END: EncryptPlain, DecryptPlain











C C ****************************************************************************
C C ASYMMETRIC ENCRYPTION











C C ****************************************************************************
C C HELPER UTILITIES



C C ==================
C C CleanFiles:
C C Cleans specific kinds of files remaining after encryption or decryption.
C C Encryption or decryption can leave behind a number of files that you may
C C wanto to keep for some time (e.g. for verification) but delete later
C C (e.g. to remove unencrypted files or to make the directory contents 
C C clean and understandable). Usually, the "-delorig" is used to do this
C C automatically when encryption/decription is performed, but sometimes 
C C you will not want to use this possibility immediately, e.g. to verify
C C that operations actually performed as you expect. In these cases,
C C you can combine encryption/decryption commands with CleanFiles.

C C Internal IG.Script.AppBase Crypto <-delencrypted> <-deldecrypted> <-delorig> file1 <file2> <file3>  ...
C C Deletes the specific kinds of files associated witth the specified input
C C files. Parameters must define which type of files are to be deleted. For
C C each file specified (either by free parameters or by directory listing
C C parameters), the associated files are identified (such as original, 
C C encrypted, or decrypted). Encrypted and decrypted files are identified 
C C through the distinctive file extensions (".ig_enc" and ".ig_dec", 
C C respectively). 
C C   file1, file2, file3, ...: free parameters that define files for which 
C C     the associated files will be deleted. Wildcards can be used to define
C C     mutiple files at once (as well as path separators to define files in
C C     locations other than current directory). For each file, the associated
C C     files (original, encrypted, decrypted) will be identified and then,
C C     according to parameters described below, it will be decided which of
C C     these files are deleted. Unless otherwise specified, the user is 
C C     asked for confirmation. Also, without the -delallversions option, 
C C     at least one version of the file will be left even if the other
C C     options instruct differently. 
C C     These file parameters can refer to any of the group of associated 
C C     files (original, encrypted and decrypted), in each case the other 
C C     files from the group will be discovered within the same directory 
C C     (according to file names and extensions) and tested for eligibility
C C     for deletion.
C C   -delencrypted: This options causes that the encrypted files (those with 
C C     the ".ig_enc" extension) from each group of associated files (i.e.
C C     the original, the encrypted and the decrypted) are deleted.
C C   -deldecrypted: This options causes that the decrypted files (those with 
C C     the ".ig_dec" extension) from each group of associated files are 
C C     deleted.
C C   -delorig: This options causes that the original files (those with 
C C     the any disrinctive extension) from each group of associated files are 
C C     deleted.
C C   -delallversions: This option specifies that it is allowed to delete all 
C C     versions of a file from ech group of files associated with input files 
C C     (i.e. the original, the encrypted and the decrypted). 
C C     WARNING: use this option with extreme caaution, as it will not be 
C C     possible to restore the original if all the associated files are 
C C     deleted, unless the files are kept in a separate backup.
C C     -yd: specifies that files will be automatically deleted, withot
C C       asking for user's confirmation. This is useful in batch executon.
C C     -nd: specifies that no files are deleted (all eventual deletions are\
C C       skipped without asking for user's confirmation). This might be 
C C       useful for just seeing the list of files that would be deleted
C C       by the operation, before actually performing it.
C C A number of other parameters are supported:
C C     -rd dir: input files will be recursively searched for in the directory
C C       named dir. Several directories for recursive file search can be
C C       specified, each one following its own -rd option.
C C     - rdl dir: similar to -rd, but order of file listing is by directory
C C       levels rather than in normal tree traversal order.
C C     -rp ptrn: specifies that files that match the specified pattern
C C       ptrn will be searched in a recursive search. Patterns can contain
C C       wildcards (e.g. "*.cmd" or "a*.txt"). Several patterns can be 
C C       specified (each one by its own -rp option), in which case all are
C C       used with all recursive directories.
C C     -rl dirLevel: specifies the level of directories for recursive search.
C C       -1 means all levels of subdirectories are searched, 0 means none

C C == Examples:

C C Examples for the CleanFiles command will be demonstrated by combining the
C C command with encryption and dectryption commands, in order to first 
C C generate the files that can be cleaned later.

C C In order to clean the generated encrypted and decrypted files (here in
C C the cryptofiles/ directory), specify the -deldecrypted and -delencrypted
C C options, with file definition options being the same as when performing
C C encryption/decryption. Both options can be specified in the single 
C C command, but in the example below two separate commands are exected
C C for the two types of associated files:
C Internal IG.Script.AppBase Crypto EncryptPlain -yo cryptofiles/*.* -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto DecryptPlain -yo cryptofiles/*.* -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto CleanFiles -deldecrypted cryptofiles/*.*
C Internal IG.Script.AppBase Crypto CleanFiles -delencrypted cryptofiles/*.*
C Internal IG.Script.AppBase Crypto EncryptPlain -yo cryptofiles/*.* -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto DecryptPlain -yo cryptofiles/*.* -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto CleanFiles -deldecrypted cryptofiles/*.*
C Internal IG.Script.AppBase Crypto CleanFiles -delencrypted cryptofiles/*.*

C C If options for deletion of all types of files (original, encrypted, 
C C decrypted) are specified then at least one verson of the file in each
C C group will remain intact(priority original, then encrypted, then 
C C decrypted) in order to make possible to restore the file. This can be 
C C overridden by the -delallversions option.
C C Because cleaning is a sensitive operation that may perform unintended
C C file deletions, it is a good idea to check which files would be deleted
C C by the specific command before actually invoking the command. This is 
C C achieved by the -nd option (used in the first CleanFiles command below).
C C All deletions are skipped, but this is reported.
C C Afterwards, deletion the -nd option is omitted such that deletions are
C C actually performed. The user is asked to confirm deletions, and at 
C C least one version of the file from ech group of associated files 
C C will remain intact:
C Internal IG.Script.AppBase Crypto EncryptPlain -yo cryptofiles/*.* -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto DecryptPlain -yo cryptofiles/*.* -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto CleanFiles -nd -delencrypted -deldecrypted -delorig cryptofiles/*.*
C Internal IG.Script.AppBase Crypto CleanFiles -delencrypted -deldecrypted -delorig cryptofiles/*.*

C C With the -nd option, some files that woluld be deleted may be listed more 
C C than once. This happens when more than one file from the group of
C C associated files are included in the list e.g. the original file and its
C C associated encrypted file. We decided that correction of this would not be
C C worth the investment as it would spoil the code in other ways.

C C Now that we are sure that CleanFiles works as expected, we can use the 
C C -yd option in order to skip user confirmations for deleting the files:
C Internal IG.Script.AppBase Crypto EncryptPlain -yo cryptofiles/*.* -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto DecryptPlain -yo cryptofiles/*.* -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto CleanFiles -yd  -delencrypted -deldecrypted -delorig cryptofiles/*.*

C C Finally, options for recursive directory listing can be used to delete 
C C the unnecessary files remaining after encryption/decryption form the whole
C C nested directory structures:
C Internal IG.Script.AppBase Crypto EncryptPlain -rd cryptofiles/ -rp *.txt -yo -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto DecryptPlain -rd cryptofiles/ -rp *.* -yo -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto CleanFiles -deldecrypted -rd cryptofiles/ -rp *.*
C Internal IG.Script.AppBase Crypto CleanFiles -delencrypted -rd cryptofiles/ -rp *.*

C C In the above commands, user is asked to confirm deleton of files. See 
C C comments on overwrite/delete confirmations. This can be omitted and 
C C files deleted automatically by specifying the -nd option:
C Internal IG.Script.AppBase Crypto EncryptPlain -rd cryptofiles/ -rp *.txt -yo -pw MyPassword11 -iv MyInitializationVector 
C Internal IG.Script.AppBase Crypto CleanFiles -yd -deldecrypted -delencrypted -rd cryptofiles/ -rp *.*

C C ==== END: CleanFiles


C C ==================
C C Convert:
C C Convers the inserted string or byte array to different formats. Input can
C C be a string or a byte array in hexadecimal or Base64 form.

C C Internal IG.Script.AppBase Crypto Convert <-bfx> <-bf64> <-bfi> input
C C   Takes input (string or byte array or long integer) in various forms
C C     and converts it to different representations.
C C   input: user input. If not specified otherwise, this is treated as string.
C C   -bfx: input is treated as byte array represented by a hexadecimal string
C C   -bf64: input is treated as byte array in Base-64 representation
C C   -bfi: input is treated as integer number
C C   -sf: input is treated as string (this is also by default)
C C These options are equivalent in this command:
C C   -bfix and -bfx, -bf64 and -bfi64, -bfi and -bfii, /sf and -sfi
C C ====

C C == Examples:

C C Convert can handle multiple inputs. Below, plain ANSII strings will be 
C C converted to different representations:
C Internal IG.Script.AppBase Crypto Convert Luxembourg London Ljubljana 

C C Now, check which bytes represent an integer and how is this written in 
C C Base-64 encoding:
C Internal IG.Script.AppBase Crypto Convert -bfi 39543786392000
C Internal IG.Script.AppBase Crypto Convert -bfii  39543786392000
C Internal IG.Script.AppBase Crypto Convert -bfii  260

C C Decode a byte array specified in hexadecimal format:
C Internal IG.Script.AppBase Crypto Convert -bfix 4c7578656d626f757267
C C See if hexadecimal with separators is understood:
C Internal IG.Script.AppBase Crypto Convert -bfix 4c-75-78-65-6d-62-6f-75-72-67
C C Decode the same byte array specified in a Base-64 format:
C Internal IG.Script.AppBase Crypto Convert -bfi64 THV4ZW1ib3VyZw==

C C Finally, check how a string converts to a byte array (without the quotes,
C C input below would be treated as multiple short strings):
C Internal IG.Script.AppBase Crypto Convert "This is a string to be converted."
C C Check if we can invert conversion properrly:
C Internal IG.Script.AppBase Crypto Convert -bfi64 VGhpcyBpcyBhIHN0cmluZyB0byBiZSBjb252ZXJ0ZWQu

C C Converter can handle multiple inputs: 
C Internal IG.Script.AppBase Crypto Convert London Ljubljana Berlin Luxembourg
C C This is also true for other input formats:
C Internal IG.Script.AppBase Crypto Convert -bfi64 TG9uZG9u TGp1YmxqYW5h QmVybGlu THV4ZW1ib3VyZw==

C C ==== END: Convert


C C  ==================
C C GetKey, GetInitializationVector or GetIV, GetSalt:
C C Generate a secret key for encryption (GetKey) or initialization vector for
C C symmetric encryption (GetInitializationVector or GetIV) or a salt (a
C C random array of bytes added to encrypted or hashed entities in order to
C C make guessing of secret information more difficult. All three types of
C C generation functions take the same parameters, they differ only in what
C C they are generating.

C C Internal IG.Script.AppBase Crypto GetKey <-pwt algType> -pwlen len -pwit 
C C       numIt keyLength <numIt> ...:
C C   Generates a key of the specified length on basis of provided password
C C     and salt (which can also be randomly generated by the command), by
C C     employing the specified generation algorithm with specified number 
C C     of iterations. More iterations there are, more time is spent for
C C     key generation, which also makes more difficult to guess the key
C C     by brute force attack.
C C   Parameters:
C C     keyLength: length of the generated key. If not specified then 
C C       default key length is used.
C C     numIt: number of iterations of the key generating algorithm.
C C     -t algType: password generatiion algorithm type, can be:
C C       - Rfc for the RFC2898 algorithm (default)
C C       - DeriveBytes for a les secure algorithm (.NET's PasswordDeriveBytes)
C C       - None for direct transformation from password to generated key
C C     -pwlen length: length of the generated key. Also used as length of
C C       password when password is not specified. Vice versa, when this 
C C       parameter is not specified, key length will be the same as length 
C C       of the provided password.
C C     -pwit numIt: number of iterations in key generation
C C A number of other parameters are supported:
C C     - klen 
C C     -pwt algType: password generation algorithm type, the same as -t.
C C     - pw password: actual password used for key generation (if not 
C C       provided then password is randomly generated).
C C     -pwx password: binary password specified in hexadecimal format
C C       "3dca9a", "3DCA9A", "3dCa9a", "3D-ca-9a" are all accepted.
C C     -bw64 password: binary password specified in base64 encoding
C C     -sl salt: password salt specified as string.
C C     -slx salt: binary password salt in hexadecimal format.
C C     -sl64 salt: password salt specified as base-64 encoded bytes.
C C     -sllen saltLength: salt length. This is used when salt is not 
C C       specified, in which case salt is randomly generated with the 
C C       specified length (if also length is not specified, then password
C C       length is used).
C C     -bfx: Result (generated key) will be returned in hexadecimal string 
C C       representation of the generated byte array representing the key.
C C     -bf64: Result (generated key) will be returned in as base-64 encoded 
C C       string representation of the generated byte array.

C C WARNINGs:
C C Passwords must be strong, such that it is difficult to guess them (they
C C should not contain words appearing in dictionary, should mix small and 
C C capital letters with numbers and other characters, should be long enough
C C (preferably at least eight characters, better more), etc. Salts should be 
C C random and should not repeat over multiple encryptions or password 
C C hashings (which is generation of a digest from a password by a 
C C cryptographic algorithm, such that correctness of the password can be 
C C checked, but it is nearly impossible to restore the password from the
C C digest).
C C When generating keys from passwords, it is also recommended that 
C C sufficient number of iterations are performed by the key generation 
C C algorithm. This makes generation take longer, which makes more difficult
C C to guess the generating passwords by trying large numbers of combinations.
C C ====

C C == Examples:
C C Generate a 20 bytes long key from the specified salt, password, and
C C number of iterations:
C Internal IG.Script.AppBase Crypto GetKey -pw TestPassword1 -sl MySalt123 21 

C C In real  situations, password and salt should be stronger (see warnings
C C above). If keys will be stored in a safe store and key generation 
C C parameters will not be inserted by humans (meaning that it will not be
C C necessary for someone to memorize them), the generating password and salt
C C can be randomly generated (note the notification about random generation):
C Internal IG.Script.AppBase Crypto GetKey 21

C C We can also specify the number of key generation iterations (otherwise,
C C default number of iterations is used), either by the pwit option or
C C by the second free parameter:
C Internal IG.Script.AppBase Crypto GetKey -pwit 3500 21
C Internal IG.Script.AppBase Crypto GetKey 21 3500 

C C When randomly generating the password and salt from which key is derived,
C C we can still specify the lengths of the randomly generated password and 
C C salt used to produce the key (otherwise, default values are taken):
C Internal IG.Script.AppBase Crypto GetKey -pwlen 14 -sllen 22 36 3200

C C Default algorithm used to generate password is recommended, but we can
C C also explicitly specify the algorithm used by the -pwt or -t option:
C Internal IG.Script.AppBase Crypto GetKey -pwt DeriveBytes -pwlen 14 -sllen 22 36 
C Internal IG.Script.AppBase Crypto GetKey -t DeriveBytes -pwlen 14 -sllen 22 36 

C C Password and salt used in key generation can be specified in a number of
C C forms: as string (-pw and -sl options) or as byte arrays in hexadecimal
C C form (-pwx and -slx options) or in base-64 encoding (-pw64 or -sl64
C C options):
C Internal IG.Script.AppBase Crypto GetKey 23 -pw Ljubljana123 -sl Luxembourg123
C Internal IG.Script.AppBase Crypto GetKey 23 -pwx 4c6a75626c6a616e61313233 -slx 4c7578656d626f757267313233
C Internal IG.Script.AppBase Crypto GetKey 23 -pw64 TGp1YmxqYW5hMTIz -sl64 THV4ZW1ib3VyZzEyMw==

C C All the above commands produce the same retult because the same password
C C and salt are specified in different format. We can also mix the formats:
C Internal IG.Script.AppBase Crypto GetKey 23 -pw Ljubljana123 -slx 4c7578656d626f757267313233
C Internal IG.Script.AppBase Crypto GetKey 23  -pw64 TGp1YmxqYW5hMTIz -sl Luxembourg123
C Internal IG.Script.AppBase Crypto GetKey 23  -pwx 4c-6a-75-62-6c-6a-61-6e-61-31-32-33 -sl64 THV4ZW1ib3VyZzEyMw==

C C Generated keys are output to console (in hexadecimal and base-64 encoding),
C C but also returned as result of the script. The returned result is in 
C C base-64 encoding (as if we used the -bf64 option), but we can make it
C C in the hexadecimal format by using the -bfx option:
C Internal IG.Script.AppBase Crypto GetKey 23 -bfx -pw Ljubljana123 -slx 4c7578656d626f757267313233

C C Beside secret keys, we can also generate initialization vectors (IV) for
C C symmetric encoding and salts. This is achieved by different commands while
C C parameter sets are exactly the same. However, for the same values of 
C C parameters, each of these commands will generate a different output:
C Internal IG.Script.AppBase Crypto GetKey 23 -pwlen 15 -sllen 21 
C Internal IG.Script.AppBase Crypto GetInitializationVector 23 -pwlen 15 -sllen 21  
C Internal IG.Script.AppBase Crypto GetSalt 23 -pwlen 15 -sllen 21  

C C ==== END: GetKey



C C ==================
C C TimeKeyGeneration:
C C Calculates average key generation time for the specified key generation 
C C algorithm, with specified password lengt, salt length, generated key
C C length, and numbef o iterations. 
C C This is very helpful in order to estimate how many iterations should you
C C take in order to meke your hashed passwords secure and to defend against
C C brute force and rainbow attacks.
C C Command has very similar set of parameters than the GetKey command, with
C C the addition of the -time option.

C C Internal IG.Script.AppBase Crypto TimeKeygeneration <-pwt algType> 
C C       <-pwlen len> -pwit numIt keyLength ...:
C C   Calculates average key generation execution execution time.
C C     keyLength: length of the generated key. If not specified then 
C C       default key length is used.
C C     -t algType: password generatiion algorithm type, can be:
C C       - Rfc for the RFC2898 algorithm (default)
C C       - DeriveBytes for a les secure algorithm (.NET's PasswordDeriveBytes)
C C       - None for direct transformation from password to generated key
C C     -pwlen length: length of the generated key. Also used as length of
C C       password when password is not specified. Vice versa, when this 
C C       parameter is not specified, key length will be the same as length 
C C       of the provided password.
C C     -pwit numIt: number of iterations in key generation
C C A number of other parameterrs are supported:
C C     - klen 
C C     -pwt algType: password generation algorithm type, the same as -t.
C C     - pw password: actual password used for key generation (if not 
C C       provided then password is randomly generated).
C C     -pwx password: binary password specified in hexadecimal format
C C       "3dca9a", "3DCA9A", "3dCa9a", "3D-ca-9a" are all accepted.
C C     -bw64 password: binary password specified in base64 encoding
C C     -sl salt: password salt specified as string.
C C     -slx salt: binary password salt in hexadecimal format.
C C     -sl salt: password salt specified as string.
C C     -sllen saltLength: salt length. This is used when salt is not 
C C       specified, in which case salt is randomly generated with the 
C C       specified length (if also length is not specified, then password
C C       length is used).
C C     -time t: targeted total execution time, default is 0.1 s.
C C ====

C C == Examples:
C C Calculate time necessary for generation of passwords with the RFC2898 
C C algorithm, with password length 15, salt length 64, and with 100 
C C iterations of generating algorithm:
C Internal IG.Script.AppBase Crypto TimeKeygeneration -pwlen 15 -sllen 64 -pwit 100 

C C You can try if the measurement is statistically precise enough by 
C C repeating the test several times and whatching whether the reposted speed 
C C changes. If seemed necessary, you can prolong expected time by using the 
C C -time option (below, number of iterations was also increased):
C Internal IG.Script.AppBase Crypto TimeKeygeneration -time 0.8 -pwlen 15 -sllen 64 -pwit 1000 

C C Check what happens if password and salt length are increased:
C Internal IG.Script.AppBase Crypto TimeKeygeneration -pwlen 15 -sllen 50 -pwit 100 
C Internal IG.Script.AppBase Crypto TimeKeygeneration -pwlen 30 -sllen 50 -pwit 100 
C Internal IG.Script.AppBase Crypto TimeKeygeneration -pwlen 60 -sllen 50 -pwit 100 
C Internal IG.Script.AppBase Crypto TimeKeygeneration -pwlen 60 -sllen 100 -pwit 100 
C Internal IG.Script.AppBase Crypto TimeKeygeneration -pwlen 60 -sllen 200 -pwit 100 
C Internal IG.Script.AppBase Crypto TimeKeygeneration -pwlen 60 -sllen 200 -pwit 1000 

C C You can also compare performance of difference algorithms:
C Internal IG.Script.AppBase Crypto TimeKeygeneration -t Rfc -pwlen 20 -sllen 100 -pwit 1000 
C Internal IG.Script.AppBase Crypto TimeKeygeneration -t DeriveBytes -pwlen 20 -sllen 100 -pwit 1000 

C C We can specify password and password salt from which keys are generated by
C C ourselves. These can be inserted as string, byte array in hexadecimal 
C C form, or byte array in base64 encoding (formats can be mixed):
C Internal IG.Script.AppBase Crypto TimeKeygeneration -pw MyPassword -sl MySalt111 -pwit 1000 
C Internal IG.Script.AppBase Crypto TimeKeygeneration -pwx A353B49CFF -sl64 kjgif7gjdgd8f0a3 -pwit 1000 
C Internal IG.Script.AppBase Crypto TimeKeygeneration -pw64 ajru79gkg7084jv7 -sl MySalt111 -pwit 1000 

C C ==== END: TimeKeyGeneration









