
// generated using Cacophony, an optional module of quasar, see: https://github.com/quasar-team/Cacophony
// generated on 2019-08-01+02:00
//SCA

bool fwSca_createDptSCA()
{
    // the names of vars and the way of generating DPT come directly from examples of dpTypeCreate
    dyn_dyn_string xxdepes;
    dyn_dyn_int xxdepei;
    dynAppend(xxdepes, makeDynString("fwScaSCA", ""));
    dynAppend(xxdepei, makeDynInt(DPEL_STRUCT));

    dynAppend(xxdepes, makeDynString("", "address"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_STRING));

    dynAppend(xxdepes, makeDynString("", "online"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_BOOL));

    dynAppend(xxdepes, makeDynString("", "id"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_UINT));

    dynAppend(xxdepes, makeDynString("", "numberRequests"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_ULONG));

    dynAppend(xxdepes, makeDynString("", "numberReplies"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_ULONG));

    dynAppend(xxdepes, makeDynString("", "lastReplySecondsAgo"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_ULONG));

    dynAppend(xxdepes, makeDynString("", "requestRate"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_FLOAT));

    dynAppend(xxdepes, makeDynString("", "numberLostReplies"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_ULONG));

    dynAppend(xxdepes, makeDynString("", "lostRepliesRate"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_FLOAT));


    int status = dpTypeCreate(xxdepes, xxdepei);
    return status == 0;
}

//AnalogInput
bool fwSca_createDptAnalogInput()
{
    // the names of vars and the way of generating DPT come directly from examples of dpTypeCreate
    dyn_dyn_string xxdepes;
    dyn_dyn_int xxdepei;
    dynAppend(xxdepes, makeDynString("fwScaAnalogInput", ""));
    dynAppend(xxdepei, makeDynInt(DPEL_STRUCT));

    dynAppend(xxdepes, makeDynString("", "value"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_FLOAT));

    dynAppend(xxdepes, makeDynString("", "rawValue"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_UINT));


    int status = dpTypeCreate(xxdepes, xxdepei);
    return status == 0;
}

//I2cMaster
bool fwSca_createDptI2cMaster()
{
    // the names of vars and the way of generating DPT come directly from examples of dpTypeCreate
    dyn_dyn_string xxdepes;
    dyn_dyn_int xxdepei;
    dynAppend(xxdepes, makeDynString("fwScaI2cMaster", ""));
    dynAppend(xxdepei, makeDynInt(DPEL_STRUCT));

    dynAppend(xxdepes, makeDynString("", "diagnostics"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_STRING));


    int status = dpTypeCreate(xxdepes, xxdepei);
    return status == 0;
}

//SpiSystem
bool fwSca_createDptSpiSystem()
{
    // the names of vars and the way of generating DPT come directly from examples of dpTypeCreate
    dyn_dyn_string xxdepes;
    dyn_dyn_int xxdepei;
    dynAppend(xxdepes, makeDynString("fwScaSpiSystem", ""));
    dynAppend(xxdepei, makeDynInt(DPEL_STRUCT));


    int status = dpTypeCreate(xxdepes, xxdepei);
    return status == 0;
}

//AnalogInputSystem
bool fwSca_createDptAnalogInputSystem()
{
    // the names of vars and the way of generating DPT come directly from examples of dpTypeCreate
    dyn_dyn_string xxdepes;
    dyn_dyn_int xxdepei;
    dynAppend(xxdepes, makeDynString("fwScaAnalogInputSystem", ""));
    dynAppend(xxdepei, makeDynInt(DPEL_STRUCT));

    dynAppend(xxdepes, makeDynString("", "generalRefreshRate"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_FLOAT));

    dynAppend(xxdepes, makeDynString("", "diagnostics"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_STRING));


    int status = dpTypeCreate(xxdepes, xxdepei);
    return status == 0;
}

//SpiSlave
bool fwSca_createDptSpiSlave()
{
    // the names of vars and the way of generating DPT come directly from examples of dpTypeCreate
    dyn_dyn_string xxdepes;
    dyn_dyn_int xxdepei;
    dynAppend(xxdepes, makeDynString("fwScaSpiSlave", ""));
    dynAppend(xxdepei, makeDynInt(DPEL_STRUCT));

    dynAppend(xxdepes, makeDynString("", "value"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_BLOB));


    int status = dpTypeCreate(xxdepes, xxdepei);
    return status == 0;
}

//DigitalIOSystem
bool fwSca_createDptDigitalIOSystem()
{
    // the names of vars and the way of generating DPT come directly from examples of dpTypeCreate
    dyn_dyn_string xxdepes;
    dyn_dyn_int xxdepei;
    dynAppend(xxdepes, makeDynString("fwScaDigitalIOSystem", ""));
    dynAppend(xxdepei, makeDynInt(DPEL_STRUCT));

    dynAppend(xxdepes, makeDynString("", "diagnostics"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_STRING));


    int status = dpTypeCreate(xxdepes, xxdepei);
    return status == 0;
}

//DigitalIO
bool fwSca_createDptDigitalIO()
{
    // the names of vars and the way of generating DPT come directly from examples of dpTypeCreate
    dyn_dyn_string xxdepes;
    dyn_dyn_int xxdepei;
    dynAppend(xxdepes, makeDynString("fwScaDigitalIO", ""));
    dynAppend(xxdepei, makeDynInt(DPEL_STRUCT));

    dynAppend(xxdepes, makeDynString("", "value"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_BOOL));


    int status = dpTypeCreate(xxdepes, xxdepei);
    return status == 0;
}

//DacSystem
bool fwSca_createDptDacSystem()
{
    // the names of vars and the way of generating DPT come directly from examples of dpTypeCreate
    dyn_dyn_string xxdepes;
    dyn_dyn_int xxdepei;
    dynAppend(xxdepes, makeDynString("fwScaDacSystem", ""));
    dynAppend(xxdepei, makeDynInt(DPEL_STRUCT));


    int status = dpTypeCreate(xxdepes, xxdepei);
    return status == 0;
}

//DacOutput
bool fwSca_createDptDacOutput()
{
    // the names of vars and the way of generating DPT come directly from examples of dpTypeCreate
    dyn_dyn_string xxdepes;
    dyn_dyn_int xxdepei;
    dynAppend(xxdepes, makeDynString("fwScaDacOutput", ""));
    dynAppend(xxdepei, makeDynInt(DPEL_STRUCT));

    dynAppend(xxdepes, makeDynString("", "voltage"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_FLOAT));


    int status = dpTypeCreate(xxdepes, xxdepei);
    return status == 0;
}

//I2cSlave
bool fwSca_createDptI2cSlave()
{
    // the names of vars and the way of generating DPT come directly from examples of dpTypeCreate
    dyn_dyn_string xxdepes;
    dyn_dyn_int xxdepei;
    dynAppend(xxdepes, makeDynString("fwScaI2cSlave", ""));
    dynAppend(xxdepei, makeDynInt(DPEL_STRUCT));

    dynAppend(xxdepes, makeDynString("", "value"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_BLOB));


    int status = dpTypeCreate(xxdepes, xxdepei);
    return status == 0;
}

//Meta
bool fwSca_createDptMeta()
{
    // the names of vars and the way of generating DPT come directly from examples of dpTypeCreate
    dyn_dyn_string xxdepes;
    dyn_dyn_int xxdepei;
    dynAppend(xxdepes, makeDynString("fwScaMeta", ""));
    dynAppend(xxdepei, makeDynInt(DPEL_STRUCT));

    dynAppend(xxdepes, makeDynString("", "versionString"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_STRING));


    int status = dpTypeCreate(xxdepes, xxdepei);
    return status == 0;
}

//XilinxFpga
bool fwSca_createDptXilinxFpga()
{
    // the names of vars and the way of generating DPT come directly from examples of dpTypeCreate
    dyn_dyn_string xxdepes;
    dyn_dyn_int xxdepei;
    dynAppend(xxdepes, makeDynString("fwScaXilinxFpga", ""));
    dynAppend(xxdepei, makeDynInt(DPEL_STRUCT));

    dynAppend(xxdepes, makeDynString("", "idcodeNumeric"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_UINT));

    dynAppend(xxdepes, makeDynString("", "idcodeString"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_STRING));


    int status = dpTypeCreate(xxdepes, xxdepei);
    return status == 0;
}

//JtagSystem
bool fwSca_createDptJtagSystem()
{
    // the names of vars and the way of generating DPT come directly from examples of dpTypeCreate
    dyn_dyn_string xxdepes;
    dyn_dyn_int xxdepei;
    dynAppend(xxdepes, makeDynString("fwScaJtagSystem", ""));
    dynAppend(xxdepei, makeDynInt(DPEL_STRUCT));


    int status = dpTypeCreate(xxdepes, xxdepei);
    return status == 0;
}

//ScaSupervisor
bool fwSca_createDptScaSupervisor()
{
    // the names of vars and the way of generating DPT come directly from examples of dpTypeCreate
    dyn_dyn_string xxdepes;
    dyn_dyn_int xxdepei;
    dynAppend(xxdepes, makeDynString("fwScaScaSupervisor", ""));
    dynAppend(xxdepei, makeDynInt(DPEL_STRUCT));

    dynAppend(xxdepes, makeDynString("", "numberOffline"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_UINT));


    int status = dpTypeCreate(xxdepes, xxdepei);
    return status == 0;
}

//AdcSampler
bool fwSca_createDptAdcSampler()
{
    // the names of vars and the way of generating DPT come directly from examples of dpTypeCreate
    dyn_dyn_string xxdepes;
    dyn_dyn_int xxdepei;
    dynAppend(xxdepes, makeDynString("fwScaAdcSampler", ""));
    dynAppend(xxdepei, makeDynInt(DPEL_STRUCT));


    int status = dpTypeCreate(xxdepes, xxdepei);
    return status == 0;
}

//GlobalStatistician
bool fwSca_createDptGlobalStatistician()
{
    // the names of vars and the way of generating DPT come directly from examples of dpTypeCreate
    dyn_dyn_string xxdepes;
    dyn_dyn_int xxdepei;
    dynAppend(xxdepes, makeDynString("fwScaGlobalStatistician", ""));
    dynAppend(xxdepei, makeDynInt(DPEL_STRUCT));

    dynAppend(xxdepes, makeDynString("", "requestRate"));
    dynAppend(xxdepei, makeDynInt(0,
                                  DPEL_FLOAT));


    int status = dpTypeCreate(xxdepes, xxdepei);
    return status == 0;
}


int fwSca_createDpts (string dptFilter=".*")
{

    {
        int result = regexpIndex(dptFilter, "SCA");
        if (result >= 0)
        {
            if (!fwSca_createDptSCA())
                return 1;
        }
        else
        {
            DebugN("DPT SCA not covered by provided dptFilter, skipping");
        }
    }

    {
        int result = regexpIndex(dptFilter, "AnalogInput");
        if (result >= 0)
        {
            if (!fwSca_createDptAnalogInput())
                return 1;
        }
        else
        {
            DebugN("DPT AnalogInput not covered by provided dptFilter, skipping");
        }
    }

    {
        int result = regexpIndex(dptFilter, "I2cMaster");
        if (result >= 0)
        {
            if (!fwSca_createDptI2cMaster())
                return 1;
        }
        else
        {
            DebugN("DPT I2cMaster not covered by provided dptFilter, skipping");
        }
    }

    {
        int result = regexpIndex(dptFilter, "SpiSystem");
        if (result >= 0)
        {
            if (!fwSca_createDptSpiSystem())
                return 1;
        }
        else
        {
            DebugN("DPT SpiSystem not covered by provided dptFilter, skipping");
        }
    }

    {
        int result = regexpIndex(dptFilter, "AnalogInputSystem");
        if (result >= 0)
        {
            if (!fwSca_createDptAnalogInputSystem())
                return 1;
        }
        else
        {
            DebugN("DPT AnalogInputSystem not covered by provided dptFilter, skipping");
        }
    }

    {
        int result = regexpIndex(dptFilter, "SpiSlave");
        if (result >= 0)
        {
            if (!fwSca_createDptSpiSlave())
                return 1;
        }
        else
        {
            DebugN("DPT SpiSlave not covered by provided dptFilter, skipping");
        }
    }

    {
        int result = regexpIndex(dptFilter, "DigitalIOSystem");
        if (result >= 0)
        {
            if (!fwSca_createDptDigitalIOSystem())
                return 1;
        }
        else
        {
            DebugN("DPT DigitalIOSystem not covered by provided dptFilter, skipping");
        }
    }

    {
        int result = regexpIndex(dptFilter, "DigitalIO");
        if (result >= 0)
        {
            if (!fwSca_createDptDigitalIO())
                return 1;
        }
        else
        {
            DebugN("DPT DigitalIO not covered by provided dptFilter, skipping");
        }
    }

    {
        int result = regexpIndex(dptFilter, "DacSystem");
        if (result >= 0)
        {
            if (!fwSca_createDptDacSystem())
                return 1;
        }
        else
        {
            DebugN("DPT DacSystem not covered by provided dptFilter, skipping");
        }
    }

    {
        int result = regexpIndex(dptFilter, "DacOutput");
        if (result >= 0)
        {
            if (!fwSca_createDptDacOutput())
                return 1;
        }
        else
        {
            DebugN("DPT DacOutput not covered by provided dptFilter, skipping");
        }
    }

    {
        int result = regexpIndex(dptFilter, "I2cSlave");
        if (result >= 0)
        {
            if (!fwSca_createDptI2cSlave())
                return 1;
        }
        else
        {
            DebugN("DPT I2cSlave not covered by provided dptFilter, skipping");
        }
    }

    {
        int result = regexpIndex(dptFilter, "Meta");
        if (result >= 0)
        {
            if (!fwSca_createDptMeta())
                return 1;
        }
        else
        {
            DebugN("DPT Meta not covered by provided dptFilter, skipping");
        }
    }

    {
        int result = regexpIndex(dptFilter, "XilinxFpga");
        if (result >= 0)
        {
            if (!fwSca_createDptXilinxFpga())
                return 1;
        }
        else
        {
            DebugN("DPT XilinxFpga not covered by provided dptFilter, skipping");
        }
    }

    {
        int result = regexpIndex(dptFilter, "JtagSystem");
        if (result >= 0)
        {
            if (!fwSca_createDptJtagSystem())
                return 1;
        }
        else
        {
            DebugN("DPT JtagSystem not covered by provided dptFilter, skipping");
        }
    }

    {
        int result = regexpIndex(dptFilter, "ScaSupervisor");
        if (result >= 0)
        {
            if (!fwSca_createDptScaSupervisor())
                return 1;
        }
        else
        {
            DebugN("DPT ScaSupervisor not covered by provided dptFilter, skipping");
        }
    }

    {
        int result = regexpIndex(dptFilter, "AdcSampler");
        if (result >= 0)
        {
            if (!fwSca_createDptAdcSampler())
                return 1;
        }
        else
        {
            DebugN("DPT AdcSampler not covered by provided dptFilter, skipping");
        }
    }

    {
        int result = regexpIndex(dptFilter, "GlobalStatistician");
        if (result >= 0)
        {
            if (!fwSca_createDptGlobalStatistician())
                return 1;
        }
        else
        {
            DebugN("DPT GlobalStatistician not covered by provided dptFilter, skipping");
        }
    }

    return 0;
}

