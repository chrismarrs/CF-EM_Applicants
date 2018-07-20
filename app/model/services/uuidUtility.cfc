component accessors="true"{

    function toBase64(uuid){
        var hexString = replace(uuid, "-", "", "all");
        var binaryValue = binaryDecode( hexString, "hex" );
        return binaryEncode( binaryValue, "base64" );
    }

    function fromBase64(encodedUUID){
        var binaryValue =  binaryDecode(encodedUUID, "base64");
        var hexString = binaryEncode(binaryValue, "hex");
        return fromHex(hexString);
    }

    function fromHex(hexString){
        if(len(hexString) != 32){
            throw("Invalid hex langth");
        }
        if(refind("[^0-9A-F]", hexString)){
            throw("Invalid String");
        }
        hexString = insert("-", hexString, 8);
        hexString = insert("-", hexString, 13);
        hexString = insert("-", hexString, 18);
        return hexString;
    }
}