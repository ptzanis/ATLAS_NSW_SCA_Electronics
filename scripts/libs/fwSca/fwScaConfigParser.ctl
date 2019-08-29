
// generated using Cacophony, an optional module of quasar, see: https://github.com/quasar-team/Cacophony
// generated on 2019-08-01+02:00


bool fwSca_addressConfigWrapper (
    string dpe,
    string address,
    int mode,
    bool active=false
)
{
    dyn_string dsExceptionInfo;
    fwPeriphAddress_setOPCUA (
        dpe /*dpe*/,
        "SCA_OPC_UA_SERVER" /* server name*/,
        65,
        "ns=2;s="+address,
        "SCA_OPC_UA_SUBSCRIPTION" /* subscription*/,
        1 /* kind */,
        1 /* variant */,
        750 /* datatype */,
        mode,
        "" /*poll group */,
        dsExceptionInfo
    );
    if (dynlen(dsExceptionInfo)>0)
        return false;
    else
        return true;
    dpSet(dpe + ":_address.._active", active);


}



void fwSca_configureSCA (
    int docNum,
    int childNode,
    string prefix,
    bool createDps,
    bool assignAddresses,
    bool continueOnError)
{
    DebugTN("Configure.SCA called");
    string name;
    xmlGetElementAttribute(docNum, childNode, "name", name);
    string fullName = prefix+name;
    string dpt = "fwSca"+"SCA";

    if (createDps)
    {
        DebugTN("Will create DP "+fullName);
        int result = dpCreate(fullName, dpt);
        if (result != 0)
        {
            DebugTN("dpCreate name='"+fullName+"' dpt='"+dpt+"' not successful or already existing");
            if (!continueOnError)
                throw(makeError("Cacophony", PRIO_SEVERE, ERR_IMPL, 1, "XXX YYY ZZZ"));
        }
    }

    if (assignAddresses)
    {
        string dpe, address;
        dyn_string dsExceptionInfo;
        bool success;

        dpe = fullName+".address";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SPONT /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }


        dpe = fullName+".online";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SPONT /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }


        dpe = fullName+".id";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SPONT /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }


        dpe = fullName+".numberRequests";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SPONT /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }


        dpe = fullName+".numberReplies";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SPONT /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }


        dpe = fullName+".lastReplySecondsAgo";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SPONT /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }


        dpe = fullName+".requestRate";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SPONT /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }


        dpe = fullName+".numberLostReplies";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SPONT /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }


        dpe = fullName+".lostRepliesRate";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SPONT /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }


    }

    dyn_int children;

    children = fwSca_getChildNodesWithName(docNum, childNode, "I2cMaster");
    for (int i=1; i<=dynlen(children); i++)
        fwSca_configureI2cMaster (docNum, children[i], fullName+"/", createDps, assignAddresses, continueOnError);

    children = fwSca_getChildNodesWithName(docNum, childNode, "SpiSystem");
    for (int i=1; i<=dynlen(children); i++)
        fwSca_configureSpiSystem (docNum, children[i], fullName+"/", createDps, assignAddresses, continueOnError);

    children = fwSca_getChildNodesWithName(docNum, childNode, "AnalogInputSystem");
    for (int i=1; i<=dynlen(children); i++)
        fwSca_configureAnalogInputSystem (docNum, children[i], fullName+"/", createDps, assignAddresses, continueOnError);

    children = fwSca_getChildNodesWithName(docNum, childNode, "DigitalIOSystem");
    for (int i=1; i<=dynlen(children); i++)
        fwSca_configureDigitalIOSystem (docNum, children[i], fullName+"/", createDps, assignAddresses, continueOnError);

    children = fwSca_getChildNodesWithName(docNum, childNode, "DacSystem");
    for (int i=1; i<=dynlen(children); i++)
        fwSca_configureDacSystem (docNum, children[i], fullName+"/", createDps, assignAddresses, continueOnError);

    children = fwSca_getChildNodesWithName(docNum, childNode, "JtagSystem");
    for (int i=1; i<=dynlen(children); i++)
        fwSca_configureJtagSystem (docNum, children[i], fullName+"/", createDps, assignAddresses, continueOnError);


}


void fwSca_configureAnalogInput (
    int docNum,
    int childNode,
    string prefix,
    bool createDps,
    bool assignAddresses,
    bool continueOnError)
{
    DebugTN("Configure.AnalogInput called");
    string name;
    xmlGetElementAttribute(docNum, childNode, "name", name);
    string fullName = prefix+name;
    string dpt = "fwSca"+"AnalogInput";

    if (createDps)
    {
        DebugTN("Will create DP "+fullName);
        int result = dpCreate(fullName, dpt);
        if (result != 0)
        {
            DebugTN("dpCreate name='"+fullName+"' dpt='"+dpt+"' not successful or already existing");
            if (!continueOnError)
                throw(makeError("Cacophony", PRIO_SEVERE, ERR_IMPL, 1, "XXX YYY ZZZ"));
        }
    }

    if (assignAddresses)
    {
        string dpe, address;
        dyn_string dsExceptionInfo;
        bool success;

        dpe = fullName+".value";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SPONT /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }


        dpe = fullName+".rawValue";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SPONT /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }


    }

    dyn_int children;


}


void fwSca_configureI2cMaster (
    int docNum,
    int childNode,
    string prefix,
    bool createDps,
    bool assignAddresses,
    bool continueOnError)
{
    DebugTN("Configure.I2cMaster called");
    string name;
    xmlGetElementAttribute(docNum, childNode, "name", name);
    string fullName = prefix+name;
    string dpt = "fwSca"+"I2cMaster";

    if (createDps)
    {
        DebugTN("Will create DP "+fullName);
        int result = dpCreate(fullName, dpt);
        if (result != 0)
        {
            DebugTN("dpCreate name='"+fullName+"' dpt='"+dpt+"' not successful or already existing");
            if (!continueOnError)
                throw(makeError("Cacophony", PRIO_SEVERE, ERR_IMPL, 1, "XXX YYY ZZZ"));
        }
    }

    if (assignAddresses)
    {
        string dpe, address;
        dyn_string dsExceptionInfo;
        bool success;

        dpe = fullName+".diagnostics";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SQUERY /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }



    }

    dyn_int children;

    children = fwSca_getChildNodesWithName(docNum, childNode, "I2cSlave");
    for (int i=1; i<=dynlen(children); i++)
        fwSca_configureI2cSlave (docNum, children[i], fullName+"/", createDps, assignAddresses, continueOnError);


}


void fwSca_configureSpiSystem (
    int docNum,
    int childNode,
    string prefix,
    bool createDps,
    bool assignAddresses,
    bool continueOnError)
{
    DebugTN("Configure.SpiSystem called");
    string name;
    xmlGetElementAttribute(docNum, childNode, "name", name);
    string fullName = prefix+name;
    string dpt = "fwSca"+"SpiSystem";

    if (createDps)
    {
        DebugTN("Will create DP "+fullName);
        int result = dpCreate(fullName, dpt);
        if (result != 0)
        {
            DebugTN("dpCreate name='"+fullName+"' dpt='"+dpt+"' not successful or already existing");
            if (!continueOnError)
                throw(makeError("Cacophony", PRIO_SEVERE, ERR_IMPL, 1, "XXX YYY ZZZ"));
        }
    }

    if (assignAddresses)
    {
        string dpe, address;
        dyn_string dsExceptionInfo;
        bool success;

    }

    dyn_int children;

    children = fwSca_getChildNodesWithName(docNum, childNode, "SpiSlave");
    for (int i=1; i<=dynlen(children); i++)
        fwSca_configureSpiSlave (docNum, children[i], fullName+"/", createDps, assignAddresses, continueOnError);


}


void fwSca_configureAnalogInputSystem (
    int docNum,
    int childNode,
    string prefix,
    bool createDps,
    bool assignAddresses,
    bool continueOnError)
{
    DebugTN("Configure.AnalogInputSystem called");
    string name;
    xmlGetElementAttribute(docNum, childNode, "name", name);
    string fullName = prefix+name;
    string dpt = "fwSca"+"AnalogInputSystem";

    if (createDps)
    {
        DebugTN("Will create DP "+fullName);
        int result = dpCreate(fullName, dpt);
        if (result != 0)
        {
            DebugTN("dpCreate name='"+fullName+"' dpt='"+dpt+"' not successful or already existing");
            if (!continueOnError)
                throw(makeError("Cacophony", PRIO_SEVERE, ERR_IMPL, 1, "XXX YYY ZZZ"));
        }
    }

    if (assignAddresses)
    {
        string dpe, address;
        dyn_string dsExceptionInfo;
        bool success;

        dpe = fullName+".generalRefreshRate";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_IO_SPONT /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }


        dpe = fullName+".diagnostics";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SQUERY /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }



    }

    dyn_int children;

    children = fwSca_getChildNodesWithName(docNum, childNode, "AnalogInput");
    for (int i=1; i<=dynlen(children); i++)
        fwSca_configureAnalogInput (docNum, children[i], fullName+"/", createDps, assignAddresses, continueOnError);


}


void fwSca_configureSpiSlave (
    int docNum,
    int childNode,
    string prefix,
    bool createDps,
    bool assignAddresses,
    bool continueOnError)
{
    DebugTN("Configure.SpiSlave called");
    string name;
    xmlGetElementAttribute(docNum, childNode, "name", name);
    string fullName = prefix+name;
    string dpt = "fwSca"+"SpiSlave";

    if (createDps)
    {
        DebugTN("Will create DP "+fullName);
        int result = dpCreate(fullName, dpt);
        if (result != 0)
        {
            DebugTN("dpCreate name='"+fullName+"' dpt='"+dpt+"' not successful or already existing");
            if (!continueOnError)
                throw(makeError("Cacophony", PRIO_SEVERE, ERR_IMPL, 1, "XXX YYY ZZZ"));
        }
    }

    if (assignAddresses)
    {
        string dpe, address;
        dyn_string dsExceptionInfo;
        bool success;

        dpe = fullName+".value";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_IO_SQUERY /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }



    }

    dyn_int children;


}


void fwSca_configureDigitalIOSystem (
    int docNum,
    int childNode,
    string prefix,
    bool createDps,
    bool assignAddresses,
    bool continueOnError)
{
    DebugTN("Configure.DigitalIOSystem called");
    string name;
    xmlGetElementAttribute(docNum, childNode, "name", name);
    string fullName = prefix+name;
    string dpt = "fwSca"+"DigitalIOSystem";

    if (createDps)
    {
        DebugTN("Will create DP "+fullName);
        int result = dpCreate(fullName, dpt);
        if (result != 0)
        {
            DebugTN("dpCreate name='"+fullName+"' dpt='"+dpt+"' not successful or already existing");
            if (!continueOnError)
                throw(makeError("Cacophony", PRIO_SEVERE, ERR_IMPL, 1, "XXX YYY ZZZ"));
        }
    }

    if (assignAddresses)
    {
        string dpe, address;
        dyn_string dsExceptionInfo;
        bool success;

        dpe = fullName+".diagnostics";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SQUERY /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }



    }

    dyn_int children;

    children = fwSca_getChildNodesWithName(docNum, childNode, "DigitalIO");
    for (int i=1; i<=dynlen(children); i++)
        fwSca_configureDigitalIO (docNum, children[i], fullName+"/", createDps, assignAddresses, continueOnError);


}


void fwSca_configureDigitalIO (
    int docNum,
    int childNode,
    string prefix,
    bool createDps,
    bool assignAddresses,
    bool continueOnError)
{
    DebugTN("Configure.DigitalIO called");
    string name;
    xmlGetElementAttribute(docNum, childNode, "name", name);
    string fullName = prefix+name;
    string dpt = "fwSca"+"DigitalIO";

    if (createDps)
    {
        DebugTN("Will create DP "+fullName);
        int result = dpCreate(fullName, dpt);
        if (result != 0)
        {
            DebugTN("dpCreate name='"+fullName+"' dpt='"+dpt+"' not successful or already existing");
            if (!continueOnError)
                throw(makeError("Cacophony", PRIO_SEVERE, ERR_IMPL, 1, "XXX YYY ZZZ"));
        }
    }

    if (assignAddresses)
    {
        string dpe, address;
        dyn_string dsExceptionInfo;
        bool success;

        dpe = fullName+".value";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_IO_SQUERY /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }



    }

    dyn_int children;


}


void fwSca_configureDacSystem (
    int docNum,
    int childNode,
    string prefix,
    bool createDps,
    bool assignAddresses,
    bool continueOnError)
{
    DebugTN("Configure.DacSystem called");
    string name;
    xmlGetElementAttribute(docNum, childNode, "name", name);
    string fullName = prefix+name;
    string dpt = "fwSca"+"DacSystem";

    if (createDps)
    {
        DebugTN("Will create DP "+fullName);
        int result = dpCreate(fullName, dpt);
        if (result != 0)
        {
            DebugTN("dpCreate name='"+fullName+"' dpt='"+dpt+"' not successful or already existing");
            if (!continueOnError)
                throw(makeError("Cacophony", PRIO_SEVERE, ERR_IMPL, 1, "XXX YYY ZZZ"));
        }
    }

    if (assignAddresses)
    {
        string dpe, address;
        dyn_string dsExceptionInfo;
        bool success;

    }

    dyn_int children;

    children = fwSca_getChildNodesWithName(docNum, childNode, "DacOutput");
    for (int i=1; i<=dynlen(children); i++)
        fwSca_configureDacOutput (docNum, children[i], fullName+"/", createDps, assignAddresses, continueOnError);


}


void fwSca_configureDacOutput (
    int docNum,
    int childNode,
    string prefix,
    bool createDps,
    bool assignAddresses,
    bool continueOnError)
{
    DebugTN("Configure.DacOutput called");
    string name;
    xmlGetElementAttribute(docNum, childNode, "name", name);
    string fullName = prefix+name;
    string dpt = "fwSca"+"DacOutput";

    if (createDps)
    {
        DebugTN("Will create DP "+fullName);
        int result = dpCreate(fullName, dpt);
        if (result != 0)
        {
            DebugTN("dpCreate name='"+fullName+"' dpt='"+dpt+"' not successful or already existing");
            if (!continueOnError)
                throw(makeError("Cacophony", PRIO_SEVERE, ERR_IMPL, 1, "XXX YYY ZZZ"));
        }
    }

    if (assignAddresses)
    {
        string dpe, address;
        dyn_string dsExceptionInfo;
        bool success;

        dpe = fullName+".voltage";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_IO_SQUERY /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }



    }

    dyn_int children;


}


void fwSca_configureI2cSlave (
    int docNum,
    int childNode,
    string prefix,
    bool createDps,
    bool assignAddresses,
    bool continueOnError)
{
    DebugTN("Configure.I2cSlave called");
    string name;
    xmlGetElementAttribute(docNum, childNode, "name", name);
    string fullName = prefix+name;
    string dpt = "fwSca"+"I2cSlave";

    if (createDps)
    {
        DebugTN("Will create DP "+fullName);
        int result = dpCreate(fullName, dpt);
        if (result != 0)
        {
            DebugTN("dpCreate name='"+fullName+"' dpt='"+dpt+"' not successful or already existing");
            if (!continueOnError)
                throw(makeError("Cacophony", PRIO_SEVERE, ERR_IMPL, 1, "XXX YYY ZZZ"));
        }
    }

    if (assignAddresses)
    {
        string dpe, address;
        dyn_string dsExceptionInfo;
        bool success;

        dpe = fullName+".value";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_IO_SQUERY /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }



    }

    dyn_int children;


}


void fwSca_configureMeta (
    int docNum,
    int childNode,
    string prefix,
    bool createDps,
    bool assignAddresses,
    bool continueOnError)
{
    DebugTN("Configure.Meta called");
    string name;
    xmlGetElementAttribute(docNum, childNode, "name", name);
    string fullName = prefix+name;
    string dpt = "fwSca"+"Meta";

    if (createDps)
    {
        DebugTN("Will create DP "+fullName);
        int result = dpCreate(fullName, dpt);
        if (result != 0)
        {
            DebugTN("dpCreate name='"+fullName+"' dpt='"+dpt+"' not successful or already existing");
            if (!continueOnError)
                throw(makeError("Cacophony", PRIO_SEVERE, ERR_IMPL, 1, "XXX YYY ZZZ"));
        }
    }

    if (assignAddresses)
    {
        string dpe, address;
        dyn_string dsExceptionInfo;
        bool success;

        dpe = fullName+".versionString";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SPONT /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }


    }

    dyn_int children;


}


void fwSca_configureXilinxFpga (
    int docNum,
    int childNode,
    string prefix,
    bool createDps,
    bool assignAddresses,
    bool continueOnError)
{
    DebugTN("Configure.XilinxFpga called");
    string name;
    xmlGetElementAttribute(docNum, childNode, "name", name);
    string fullName = prefix+name;
    string dpt = "fwSca"+"XilinxFpga";

    if (createDps)
    {
        DebugTN("Will create DP "+fullName);
        int result = dpCreate(fullName, dpt);
        if (result != 0)
        {
            DebugTN("dpCreate name='"+fullName+"' dpt='"+dpt+"' not successful or already existing");
            if (!continueOnError)
                throw(makeError("Cacophony", PRIO_SEVERE, ERR_IMPL, 1, "XXX YYY ZZZ"));
        }
    }

    if (assignAddresses)
    {
        string dpe, address;
        dyn_string dsExceptionInfo;
        bool success;

        dpe = fullName+".idcodeNumeric";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SQUERY /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }



        dpe = fullName+".idcodeString";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SQUERY /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }



    }

    dyn_int children;


}


void fwSca_configureJtagSystem (
    int docNum,
    int childNode,
    string prefix,
    bool createDps,
    bool assignAddresses,
    bool continueOnError)
{
    DebugTN("Configure.JtagSystem called");
    string name;
    xmlGetElementAttribute(docNum, childNode, "name", name);
    string fullName = prefix+name;
    string dpt = "fwSca"+"JtagSystem";

    if (createDps)
    {
        DebugTN("Will create DP "+fullName);
        int result = dpCreate(fullName, dpt);
        if (result != 0)
        {
            DebugTN("dpCreate name='"+fullName+"' dpt='"+dpt+"' not successful or already existing");
            if (!continueOnError)
                throw(makeError("Cacophony", PRIO_SEVERE, ERR_IMPL, 1, "XXX YYY ZZZ"));
        }
    }

    if (assignAddresses)
    {
        string dpe, address;
        dyn_string dsExceptionInfo;
        bool success;

    }

    dyn_int children;

    children = fwSca_getChildNodesWithName(docNum, childNode, "XilinxFpga");
    for (int i=1; i<=dynlen(children); i++)
        fwSca_configureXilinxFpga (docNum, children[i], fullName+"/", createDps, assignAddresses, continueOnError);


}


void fwSca_configureScaSupervisor (
    int docNum,
    int childNode,
    string prefix,
    bool createDps,
    bool assignAddresses,
    bool continueOnError)
{
    DebugTN("Configure.ScaSupervisor called");
    string name;
    xmlGetElementAttribute(docNum, childNode, "name", name);
    string fullName = prefix+name;
    string dpt = "fwSca"+"ScaSupervisor";

    if (createDps)
    {
        DebugTN("Will create DP "+fullName);
        int result = dpCreate(fullName, dpt);
        if (result != 0)
        {
            DebugTN("dpCreate name='"+fullName+"' dpt='"+dpt+"' not successful or already existing");
            if (!continueOnError)
                throw(makeError("Cacophony", PRIO_SEVERE, ERR_IMPL, 1, "XXX YYY ZZZ"));
        }
    }

    if (assignAddresses)
    {
        string dpe, address;
        dyn_string dsExceptionInfo;
        bool success;

        dpe = fullName+".numberOffline";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SPONT /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }


    }

    dyn_int children;


}


void fwSca_configureAdcSampler (
    int docNum,
    int childNode,
    string prefix,
    bool createDps,
    bool assignAddresses,
    bool continueOnError)
{
    DebugTN("Configure.AdcSampler called");
    string name;
    xmlGetElementAttribute(docNum, childNode, "name", name);
    string fullName = prefix+name;
    string dpt = "fwSca"+"AdcSampler";

    if (createDps)
    {
        DebugTN("Will create DP "+fullName);
        int result = dpCreate(fullName, dpt);
        if (result != 0)
        {
            DebugTN("dpCreate name='"+fullName+"' dpt='"+dpt+"' not successful or already existing");
            if (!continueOnError)
                throw(makeError("Cacophony", PRIO_SEVERE, ERR_IMPL, 1, "XXX YYY ZZZ"));
        }
    }

    if (assignAddresses)
    {
        string dpe, address;
        dyn_string dsExceptionInfo;
        bool success;

    }

    dyn_int children;


}


void fwSca_configureGlobalStatistician (
    int docNum,
    int childNode,
    string prefix,
    bool createDps,
    bool assignAddresses,
    bool continueOnError)
{
    DebugTN("Configure.GlobalStatistician called");
    string name;
    xmlGetElementAttribute(docNum, childNode, "name", name);
    string fullName = prefix+name;
    string dpt = "fwSca"+"GlobalStatistician";

    if (createDps)
    {
        DebugTN("Will create DP "+fullName);
        int result = dpCreate(fullName, dpt);
        if (result != 0)
        {
            DebugTN("dpCreate name='"+fullName+"' dpt='"+dpt+"' not successful or already existing");
            if (!continueOnError)
                throw(makeError("Cacophony", PRIO_SEVERE, ERR_IMPL, 1, "XXX YYY ZZZ"));
        }
    }

    if (assignAddresses)
    {
        string dpe, address;
        dyn_string dsExceptionInfo;
        bool success;

        dpe = fullName+".requestRate";
        address = dpe; // address can be generated from dpe after some mods ...
        strreplace(address, "/", ".");

        success = fwSca_addressConfigWrapper(
                      dpe,
                      address,
                      DPATTR_ADDR_MODE_INPUT_SPONT /* mode */);

        if (!success)
        {
            DebugTN("Failed setting address "+address+"; will terminate now.");
            return false;
        }


    }

    dyn_int children;


}



dyn_int fwSca_getChildNodesWithName (int docNum, int parentNode, string name)
{
    dyn_int result;
    int node = xmlFirstChild(docNum, parentNode);
    while (node >= 0)
    {
        if (xmlNodeName(docNum, node)==name)
            dynAppend(result, node);
        node = xmlNextSibling (docNum, node);
    }
    return result;
}

int fwSca_parseConfig (string configFileName, bool createDps, bool assignAddresses, bool continueOnError )
/* Create instances */
{
    string errMsg;
    int errLine;
    int errColumn;
    int docNum = xmlDocumentFromFile(configFileName, errMsg, errLine, errColumn);
    if (docNum < 0)
    {
        DebugN("Didn't open the file: at Line="+errLine+" Column="+errColumn+" Message=" + errMsg);
        return -1;
    }

    int firstNode = xmlFirstChild(docNum);
    if (firstNode < 0)
    {
        DebugN("Cant get the first child of the config file.");
        return -1;
    }
    while (xmlNodeName(docNum, firstNode) != "configuration")
    {
        firstNode = xmlNextSibling(docNum, firstNode);
        if (firstNode < 0)
        {
            DebugTN("configuration node not found, sorry.");
            return -1;
        }
    }
    // now firstNode holds configuration node
    dyn_int children;

    dyn_int children = fwSca_getChildNodesWithName(docNum, firstNode, "SCA");
    for (int i = 1; i<=dynlen(children); i++)
    {
        fwSca_configureSCA (docNum, children[i], "", createDps, assignAddresses, continueOnError);
    }

    dyn_int children = fwSca_getChildNodesWithName(docNum, firstNode, "AdcSampler");
    for (int i = 1; i<=dynlen(children); i++)
    {
        fwSca_configureAdcSampler (docNum, children[i], "", createDps, assignAddresses, continueOnError);
    }



    return 0;
}

