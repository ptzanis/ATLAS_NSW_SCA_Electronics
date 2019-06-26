//////////////////////////////////////////////////////////
/** This function creates a component description file (xml).

@param pathName						(in) path for the output file {if empty, only create xmlDesc}
@param componentName			(in) name of the component {required} 
@param componentVersion		(in) version number of the component {required} 
@param componentDate			(in) date of the component {will set current date if empty}
@param requiredComponents	(in) list of required components (componentName=minimalVersionNumber)
@param isSubComponent			(in) TRUE if subcomponent
@param initScripts				(in) scripts to be run during installation 
@param deleteScripts			(in) scripts to be run during deletion 
@param postInstallScripts	(in) scripts to be run after installation and subsequent restart {
@param postDeleteScripts	(in) scripts to be run after deletion and subsequent restart 
@param configFiles				(in) config files for the project {need to be in ./config/, do not specify path}
@param asciiFiles			  	(in) dplist files for the project {need to be in ./dplist/, do not specify path}
@param panelFiles					(in) panel files for the project {need to be in ./panels/, do only specify sub-path}
@param scriptFiles				(in) script files for the project {need to be in ./scripts/, do only specify sub-path}
@param libraryFiles				(in) library files for the project {need to be in ./scripts/libs/, do only specify sub-path}
@param otherFiles					(in) miscellaneous files for the project {do only specify sub-path from PROJ_PATH}
@param dontRestartProject					(in) flag indicating if the restart of the project can be omitted after the installation of the component
@param xmlDesc						(out) complete xml description
@return 0 - xml file created, -1 - file creation failed, -2 - parameters missing
@author Sascha Schmeling and Fernando Varela.
*/
int fwInstallationXml_create(	string pathName,
                              string componentName,
                              string componentVersion,
                              string componentDate,
                              dyn_string requiredComponents,
                              bool isSubComponent,
                              dyn_string preInitScripts,
                              dyn_string initScripts, 
                              dyn_string deleteScripts,
                              dyn_string postInstallScripts, 
                              dyn_string postDeleteScripts,
                              dyn_string configFiles,
                              dyn_string asciiFiles,
                              dyn_string panelFiles,
                              dyn_string scriptFiles,
                              dyn_string libraryFiles,
                              dyn_string otherFiles,
                              bool dontRestartProject,
                              dyn_string & xmlDesc)
{
  

  fwInstallation_flagDeprecated("fwInstallationXml_create", "fwInstallationXml_createComponentFile");  
  
//	dyn_string xmlDesc;
	dynClear(xmlDesc);
	
	time now = getCurrentTime();
	
	dynClear(xmlDesc);

	if(requiredComponents =="")
		dynClear(requiredComponents);
	if(initScripts =="")
		dynClear(initScripts);
	if(deleteScripts =="")
		dynClear(deleteScripts);
	if(postInstallScripts =="")
		dynClear(postInstallScripts);
	if(postDeleteScripts =="")
		dynClear(postDeleteScripts);
	if(configFiles =="")
		dynClear(configFiles);
	if(asciiFiles =="")
		dynClear(asciiFiles);
	if(panelFiles =="")
		dynClear(panelFiles);
	if(scriptFiles =="")
		dynClear(scriptFiles);
	if(libraryFiles =="")
		dynClear(libraryFiles);
	if(otherFiles =="")
		dynClear(otherFiles);

	if(componentName == "")
	{
		DebugTN("Your component should have a name!");
		return -2;		
	}
	if(componentVersion == "")
	{
		DebugTN("Your component should have a version number!");
		return -2;
	}

// build xml code	
	dynAppend(xmlDesc, "<component>");
// component name
	dynAppend(xmlDesc, "<name>" + componentName + "</name>");
// component version
	dynAppend(xmlDesc, "<version>" + componentVersion + "</version>");
// release date
	if(componentDate == "")
		componentDate = year(now)+"/"+month(now)+"/"+day(now);
	dynAppend(xmlDesc, "<date>" + componentDate + "</date>");

// required components
	if(dynlen(requiredComponents) > 0)
		for(int i=1; i<=dynlen(requiredComponents); i++)
			dynAppend(xmlDesc, "<required>"+requiredComponents[i]+"</required>");

// sub-component?
	if(isSubComponent == TRUE)
		dynAppend(xmlDesc, "<subcomponent>yes</subcomponent>");

//avoid project restart:        
	if(dontRestartProject == TRUE)
		dynAppend(xmlDesc, "<dontRestartProject>TRUE</dontRestartProject>");

////////////////FVR: Move init and post install scripts to scripts folder according to the FW Guidelines.
// init script(s)
	if(dynlen(initScripts) > 0)
          		for(int i=1; i<=dynlen(initScripts); i++){
			  //dynAppend(xmlDesc, "<init>./config/"+initScripts[i]+"</init>");
    if(!patternMatch("./scripts/" + componentName + "/*", initScripts[i]))
      dynAppend(xmlDesc, "<init>./scripts/" + componentName + "/" + initScripts[i]+"</init>");
    else
      dynAppend(xmlDesc, "<init>" + initScripts[i]+"</init>");
      
                      }
// delete script(s)
	if(dynlen(deleteScripts) > 0)
          		for(int i=1; i<=dynlen(deleteScripts); i++){
			  //dynAppend(xmlDesc, "<delete>./config/"+deleteScripts[i]+"</delete>");
    if(!patternMatch("./scripts/" + componentName + "/*", deleteScripts[i]))
      dynAppend(xmlDesc, "<delete>./scripts/" + componentName + "/" + deleteScripts[i]+"</delete>");
    else
      dynAppend(xmlDesc, "<delete>" + deleteScripts[i]+"</delete>");
                        }
// postInstall script(s)
	if(dynlen(postInstallScripts)> 0)
          		for(int i=1; i<=dynlen(postInstallScripts); i++){
			  //dynAppend(xmlDesc, "<postInstall>./config/"+postInstallScripts[i]+"</postInstall>");
    if(!patternMatch("./scripts/" + componentName + "/*", postInstallScripts[i]))
      dynAppend(xmlDesc, "<postInstall>./scripts/" + componentName + "/" + postInstallScripts[i]+"</postInstall>");
    else
      dynAppend(xmlDesc, "<postInstall>" + postInstallScripts[i]+"</postInstall>");
                        }

// postDelete script(s)
	if(dynlen(postDeleteScripts) > 0)
          		for(int i=1; i<=dynlen(postDeleteScripts); i++){
			//dynAppend(xmlDesc, "<postDelete>./config/"+postDeleteScripts[i]+"</postDelete>");
    if(!patternMatch("./scripts/" + componentName + "/*", postDeleteScripts[i]))
      dynAppend(xmlDesc, "<postDelete>./scripts/" + componentName + "/" + postDeleteScripts[i]+"</postDelete>");
    else
      dynAppend(xmlDesc, "<postDelete>" + postDeleteScripts[i]+"</postDelete>");
      
                      }
/////////////////FVR
        
// config files
	if(dynlen(configFiles) > 0)
		for(int i=1; i<=dynlen(configFiles); i++)
			if(strpos(configFiles[i], ".windows") > 0)
      if(!patternMatch("./config/*", configFiles[i]))
  				dynAppend(xmlDesc, "<config_windows>./config/"+configFiles[i]+"</config_windows>");
      else
  				dynAppend(xmlDesc, "<config_windows>"+configFiles[i]+"</config_windows>");
        
			else if(strpos(configFiles[i], ".linux") > 0)
      if(!patternMatch("./config/*", configFiles[i]))
  				dynAppend(xmlDesc, "<config_linux>./config/"+configFiles[i]+"</config_linux>");
      else
  				dynAppend(xmlDesc, "<config_linux>"+configFiles[i]+"</config_linux>");
        
			else 
      if(!patternMatch("./config/*", configFiles[i]))
  				dynAppend(xmlDesc, "<config>./config/"+configFiles[i]+"</config>");
      else
  				dynAppend(xmlDesc, "<config>"+configFiles[i]+"</config>");
        

// ascii import files
	if(dynlen(asciiFiles) > 0)
		for(int i=1; i<=dynlen(asciiFiles); i++)
    if(!patternMatch("./dplist/*", asciiFiles[i]))
  			dynAppend(xmlDesc, "<dplist>./dplist/"+asciiFiles[i]+"</dplist>");
    else
  			dynAppend(xmlDesc, "<dplist>"+asciiFiles[i]+"</dplist>");
      

// panel files
	if(dynlen(panelFiles) > 0)
		for(int i=1; i<=dynlen(panelFiles); i++)
    if(!patternMatch("./panels/*", panelFiles[i]))
			dynAppend(xmlDesc, "<file>./panels/"+panelFiles[i]+"</file>");
    else
  	   dynAppend(xmlDesc, "<file>"+panelFiles[i]+"</file>");
      
// script files		
	if(dynlen(scriptFiles) > 0)
		for(int i=1; i<=dynlen(scriptFiles); i++)
    if(!patternMatch("./scripts/*", scriptFiles[i]))
  			dynAppend(xmlDesc, "<file>./scripts/"+scriptFiles[i]+"</file>");
    else
  			dynAppend(xmlDesc, "<file>"+scriptFiles[i]+"</file>");
      
// library files
	if(dynlen(libraryFiles) > 0)
		for(int i=1; i<=dynlen(libraryFiles); i++)
    if(!patternMatch("./scripts/libs/*", libraryFiles[i]))
  			dynAppend(xmlDesc, "<file>./scripts/libs/"+libraryFiles[i]+"</file>");
    else
  			dynAppend(xmlDesc, "<file>"+libraryFiles[i]+"</file>");
      
// misc files
	if(dynlen(otherFiles) > 0)
		for(int i=1; i<=dynlen(otherFiles); i++)
      if(!patternMatch("./*", otherFiles[i]))
        dynAppend(xmlDesc, "<file>./"+otherFiles[i]+"</file>");
      else
        dynAppend(xmlDesc, "<file>"+otherFiles[i]+"</file>");
        

//	DebugTN(otherFiles, componentName+ ".xml", dynContains(otherFiles, componentName+ ".xml"), xmlDesc);
	
	if(dynContains(xmlDesc, "<file>./"+componentName+ ".xml</file>") <= 0)
	  dynAppend(xmlDesc, "<file>./"+componentName+ ".xml</file>");


	dynAppend(xmlDesc, "</component>");
        
// write xmlFile
	if(pathName != "")
	{
		file xmlText = fopen(pathName+"/"+componentName+".xml", "w");
		if(ferror(xmlText) != 0)
		{
			fclose(xmlText);
			return -1;
		}
		if(dynlen(xmlDesc) > 0)
		{
			for(int i=1; i<=dynlen(xmlDesc); i++)
				fputs(xmlDesc[i]+"\n", xmlText);
		}
		fclose(xmlText);
	}
  
  return 0;
}



int fwInstallationDBAgent_isManagerRunning(string manager, string commandLine, bool &isRunning) 
{
  fwInstallation_flagDeprecated("fwInstallationDBAgent_isManagerRunning", "fwInstallationManager_isRunning");
  return fwInstallationManager_isRunning(manager, commandLine, isRunning);
}


/*
bool fwInstallation_checkToolVersion(string systemName = "")
{
  fwInstallation_flagDeprecated("fwInstallation_checkToolVersion");
  bool versionOK = true;
  string version; 
  dyn_string ds1, ds2;
  int a, b;
  int max;
  
  if(systemName == "")
    systemName = getSystemName();
    
  if(!patternMatch("*:", systemName))
    systemName += ":";
    
  if(fwInstallation_getToolVersion(version, systemName) != 0)
    return false;
  
  ds1 = strsplit(version, ".");
  ds2 = strsplit(csFwInstallationToolVersion, ".");
  
  if(dynlen(ds1) > 0){

    if(dynlen(ds1) > dynlen(ds2))
      max = dynlen(ds2);
    else
      max = dynlen(ds1);
      
    for(int i = 1; i <= max; i++){

      sscanf(ds1[i], "%d", a);
      sscanf(ds2[i], "%d", b);

      if(b > a)
        versionOK = false;
      
    }  
  }else
    versionOK = false;  

  return versionOK;

}
*/
int fwInstallation_managerCommand(string action, string manager, string commandLine)
{
  fwInstallation_flagDeprecated("fwInstallation_managerCommand()", "fwInstallationManager_command()");
  return fwInstallationManager_command(action, manager, commandLine);
}


int fwInstallation_packagerExportFSM(string componentName, string sourcePath, dyn_string rootNodes, dyn_string doNotExportTypes)
{
  fwInstallation_flagDeprecated("fwInstallation_packagerExportFSM", "fwInstallationPackager_exportFsm");
  return fwInstallationPackager_exportFsm(componentName, sourcePath, rootNodes, doNotExportTypes);
}

//////////////////////Managers:

int fwInstallation_getManagersInfoFromPvss(dyn_dyn_mixed &managersInfo)
{
  fwInstallation_flagDeprecated("fwInstallation_getManagersInfoFromPvss", "fwInstallationManager_getAllInfoFromPvss");
  return fwInstallationManager_getAllInfoFromPvss(managersInfo);
}

int fwInstallation_getRedundancyNumber()
{
  fwInstallation_flagDeprecated("fwInstallation_getRedundancyNumber");
  return -1;   
}


/** This function retrieves the component information from the xml file and
	displays it in the panel

@param descFile: the name of a file with component description

@author M.Sliwinski
*/

fwInstallation_getComponentDescriptionXML(string descFile)
{
  fwInstallation_flagDeprecated("fwInstallation_getComponentDescriptionXML()", "fwInstallationXml_getComponentDescription()");
  fwInstallationXml_getComponentDescription(descFile);
}

int fwInstallation_parseXmlFile(string sourceDir, 
                                string descFile, 
                                string subPath,
				                          string destinationDir,
                                string &componentName,
				                          string &componentVersion,
				                          dyn_string &dynSubComponents,
                                dyn_string &dynFileNames,
                                dyn_string &dynComponentFiles,
                                dyn_string &dynPostDeleteFiles_current,
                                dyn_string &dynPostInstallFiles_current,
                                dyn_string &dynPostDeleteFiles,
                                dyn_string &dynPostInstallFiles,
                                dyn_string &dynConfigFiles_general,
                                dyn_string &dynConfigFiles_linux,
                                dyn_string &dynConfigFiles_windows,
                                dyn_string &dynInitFiles,
                                dyn_string &dynDeleteFiles,
                                dyn_string &dynDplistFiles,
                                dyn_string &dynScriptsToBeAdded, 
                                string &helpFile,
                                string &componentDate,
                                dyn_string &comments,
                                dyn_string & dynRequiredComponents)
{
  
  fwInstallation_flagDeprecated("fwInstallation_parseXmlFile()", "fwInstallationXml_parseFile()");
  return fwInstallationXml_parseFile(sourceDir, 
                                descFile, 
                                subPath,
				                          destinationDir,
                                componentName,
				                          componentVersion,
				                          dynSubComponents,
                                dynFileNames,
                                dynComponentFiles,
                                dynPostDeleteFiles_current,
                                dynPostInstallFiles_current,
                                dynPostDeleteFiles,
                                dynPostInstallFiles,
                                dynConfigFiles_general,
                                dynConfigFiles_linux,
                                dynConfigFiles_windows,
                                dynInitFiles,
                                dynDeleteFiles,
                                dynDplistFiles,
                                dynScriptsToBeAdded, 
                                helpFile,
                                componentDate,
                                comments,
                                dynRequiredComponents);
}

/** This function updates the fwScripts.lst file to be run by ctrl manager

@param dynScriptsToBeAdded: a dynamic string with file names of scripts to be added to fwScripts.lst file
@param strComponentName: the name of the component for which the scripts are added
@author M.Sliwinski
*/

fwInstallation_addScriptsIntoFile(dyn_string & dynScriptsToBeAdded, string strComponentName)
{
fwInstallation_flagDeprecated("fwInstallation_addScriptsIntoFile", "");
		dyn_string dynLoadedScripts;   // all the scripts that were loaded from fwScripts.lst
		dyn_string dynScriptsFileLines;
		string strScriptsFileName = getPath(SCRIPTS_REL_PATH) + "fwScripts.lst";
		string scriptsFileInString;
		string strScriptsFileLine;
		dyn_string dynLinesToBeAdded;
		dyn_string dynTmpDirFile;
		int idxOfScriptName;
		int i;
		bool fileLoaded;
		int canAccessFile;
				
		canAccessFile = access(strScriptsFileName, F_OK);
		
		if(canAccessFile == 0)
		{
			
			fileLoaded = fileToString(strScriptsFileName, scriptsFileInString);

			if (! fileLoaded )
			{
			
				fwInstallation_throw("fwInstallation: Error loading the file: " + strScriptsFileName);
				
			}
			else 
			{
				
				dynScriptsFileLines = strsplit(scriptsFileInString, "\n");
				
				for( i = 1; i <= dynlen(dynScriptsFileLines); i++)
				{
					strScriptsFileLine = strrtrim(strltrim(dynScriptsFileLines[i]));
					
					if(strScriptsFileLine == "")
					{
						// this is a blank line
					}
					else if( strtok(strScriptsFileLine, "#") == 0)
					{
						// this is a comment
					}
					else
					{
						// this is a script entry
						dynAppend(dynLoadedScripts, strScriptsFileLine);
					}

				}
				

			}
		}
		else
		{
			fwInstallation_throw("fwInstallation: The file : " + strScriptsFileName + " does not exist", "error", 3);
		}
		
		// what should be added
		dynAppend(dynLinesToBeAdded, "#begin " + strComponentName);
		dynAppend(dynLinesToBeAdded, "# if this parametrisation is empty that means that the scripts were already defined in the file");
		dynAppend(dynLinesToBeAdded, "");
		
		for ( i = 1; i <= dynlen(dynScriptsToBeAdded); i++)
		{
			if(dynContains(dynLoadedScripts, dynScriptsToBeAdded[i]) > 0)
			{
				// the parametrisation is already done	
				DebugN("fwInstallation: The parametrisation is already done for: " + dynScriptsToBeAdded[i]);	
			}
			else 
			{
				// update the loaded scripts - the scripts that were loaded from the old file
				dynAppend(dynLoadedScripts, dynScriptsToBeAdded[i]);
				
				// add the script file names to - the lines to be added
				
				// get the script name from the relative path
				
				dynTmpDirFile = strsplit(dynScriptsToBeAdded[i], "/");
				
				// get the index of the script file name
				idxOfScriptName = dynlen(dynTmpDirFile);
				
				// append the script file name to the lines to be added
				dynAppend(dynLinesToBeAdded, dynTmpDirFile[idxOfScriptName]);
				DebugN("fwInstallation: Adding the parameterization for: " + dynScriptsToBeAdded[i]);	
			}
		}
		
		dynAppend(dynLinesToBeAdded, "");
		dynAppend(dynLinesToBeAdded, "#end " + strComponentName);

		// add an empty line at the end of component definition - for readability
		dynAppend(dynLinesToBeAdded, "");		 
		
		// if the fwScripts.lst is empty the PVSS00ctl manager does not start
		// the fwInstallationFakeScript.ctl is added to correct this problem
		
		if(dynContains(dynLoadedScripts, "fwInstallationFakeScript.ctl"))
		{
		
		}
		else
		{
			dynAppend(dynLinesToBeAdded, "fwInstallationFakeScript.ctl");
		}
		
		// append the new lines to the dyn_string that contains lines from old file
		
		dynAppend(dynScriptsFileLines, dynLinesToBeAdded);
		
		fwInstallation_saveFile( dynScriptsFileLines, strScriptsFileName);

}


/** This function checks the progs file if the fwScripts.lst has been added to it

@return : 0 - if fwScripts.lst is added into progs file, -1 - if fwScripts.lst does not exist in progs file
@author M.Sliwinski
*/

int fwInstallation_fwScriptsAddedToProgsFile()
{
fwInstallation_flagDeprecated("fwInstallation_fwScriptsAddedToProgsFile", "");
	bool fileLoaded;
	string strScriptsFileName = getPath(CONFIG_REL_PATH) + "progs";
	string scriptsFileInString;

			fileLoaded = fileToString(strScriptsFileName, scriptsFileInString);

			if (! fileLoaded )
			{
			
				return -1;
				
			}
			else 
			{
				if(strpos(scriptsFileInString, "fwScripts.lst") >= 0)
				{
					return 0;
				}
				else
				{
					return -1;
				}
				

			}
}

int _fwInstallation_decodeXML(string strComponentFile,
							string & componentName, string & componentVersion, string & date,
							dyn_string & dynRequiredComponents,
							bool & isSubComponent,
							dyn_string & dynInitFiles, dyn_string & dynDeleteFiles, 
							dyn_string & dynPostInstallFiles, dyn_string & dynPostDeleteFiles, 
							dyn_string & dynConfigFiles_general, dyn_string & dynConfigFiles_windows, dyn_string & dynConfigFiles_linux,
							dyn_string & dynDplistFiles,
							dyn_string & dynPanelFiles,
							dyn_string & dynScriptFiles,
							dyn_string & dynLibFiles,
							dyn_string & dynComponentFiles,
							dyn_string & dynSubComponents,
							dyn_string & dynScriptsToBeAdded,
							dyn_string & dynFileNames,
           string &dontRestartProject)
{
  fwInstallation_flagDeprecated("_fwInstallation_decodeXML", "fwInstallationXml_decode");
  
  dyn_string dynPreInitFiles;
  return fwInstallationXml_decode(strComponentFile,
							componentName, componentVersion, date,
							dynRequiredComponents,
							isSubComponent,
							dynPreInitFiles, dynInitFiles, dynDeleteFiles, 
							dynPostInstallFiles, dynPostDeleteFiles, 
							dynConfigFiles_general, dynConfigFiles_windows, dynConfigFiles_linux,
							dynDplistFiles,
							dynPanelFiles,
							dynScriptFiles,
							dynLibFiles,
							dynComponentFiles,
							dynSubComponents,
							dynScriptsToBeAdded,
							dynFileNames,
           dontRestartProject);
}


/** This function allows to make an ASCII export with specific filters.

@param fileName						path and name of the output file
@param dataPointNames			names of the dps to be put out
@param dataPointTypes			names of the dpts to be put out (default all)
@param filter							filter on dps/dpts (default dps with alerts, params, and original values)
@author Sascha Schmeling and Fernando Varela
*/

fwInstallation_createDpl(	string fileName, dyn_string dataPointNames, 
													dyn_string dataPointTypes = "",
													string filter = "DAOP")
{
  fwInstallation_flagDeprecated("fwInstallation_createDpl", "fwInstallationPackager_createDpl");
  fwInstallationPackager_createDpl(fileName, dataPointNames, dataPointTypes, filter);
}

int fwInstallation_createXml(	string pathName,
                                string componentName, 
                                string componentVersion, 
                                string componentDate,
                                dyn_string requiredComponents,
		                bool isSubComponent,
			        dyn_string initScripts, dyn_string deleteScripts,
				dyn_string postInstallScripts, dyn_string postDeleteScripts,
				dyn_string configFiles, 
				dyn_string asciiFiles,
				dyn_string panelFiles,
				dyn_string scriptFiles,
				dyn_string libraryFiles,
				dyn_string otherFiles,
                                string dontRestartProject,
				dyn_string & xmlDesc)
{

  fwInstallation_flagDeprecated("fwInstallation_createXml()", "fwInstallationXml_create()");
  return  fwInstallation_createXml(pathName, componentName, componentVersion, componentDate, requiredComponents,
                                   isSubComponent, initScripts, deleteScripts, postInstallScripts, postDeleteScripts,
                                   configFiles, asciiFiles, panelFiles, scriptFiles, libraryFiles, otherFiles, dontRestartProject, xmlDesc);
}

int fwInstallation_loadXml(string fileName,
			   string & componentName, 
        string & componentVersion, 
        string & componentDate,
			   dyn_string & requiredComponents,
			   bool & isSubComponent,
			   dyn_string & initScripts,
        dyn_string & deleteScripts,
			   dyn_string & postInstallScripts,
        dyn_string & postDeleteScripts,
			   dyn_string & configFiles, 
			   dyn_string & dplistFiles,
			   dyn_string & panelFiles,
			   dyn_string & scriptFiles,
			   dyn_string & libraryFiles,
			   dyn_string & otherFiles,
			   dyn_string & xmlDesc,
        string &dontRestartProject,
        string &helpFile,
        dyn_string &subComponents,
        dyn_string &config_windows,
        dyn_string &config_linux,
        dyn_string & scriptsToBeAddedFiles,
        dyn_string &comments)
{

  fwInstallation_flagDeprecated("fwInstallation_loadXml()", "fwInstallationXml_load()");
  dyn_dyn_mixed componentInfo;
  if(fwInstallationXml_load(fileName, componentInfo) < 0)
  {
    fwInstallation_throw("fwInstallation_loadXml()-> Failed to load: " + fileName);
    return -1;
  }
  
  componentName = componentInfo[FW_INSTALLATION_XML_COMPONENT_NAME];
  componentVersion = componentInfo[FW_INSTALLATION_XML_COMPONENT_VERSION];
  componentDate = componentInfo[FW_INSTALLATION_XML_COMPONENT_DATE];
  requiredComponents = componentInfo[FW_INSTALLATION_XML_COMPONENT_REQUIRED_COMPONENTS];
  isSubComponent = componentInfo[FW_INSTALLATION_XML_COMPONENT_IS_SUBCOMPONENT];
  initScripts = componentInfo[FW_INSTALLATION_XML_COMPONENT_INIT_SCRIPTS];
  deleteScripts = componentInfo[FW_INSTALLATION_XML_COMPONENT_DELETE_SCRIPTS];
  postInstallScripts = componentInfo[FW_INSTALLATION_XML_COMPONENT_POST_INSTALL_SCRIPTS];
  postDeleteScripts = componentInfo[FW_INSTALLATION_XML_COMPONENT_POST_DELETE_SCRIPTS];
  configFiles = componentInfo[FW_INSTALLATION_XML_COMPONENT_CONFIG_FILES];
  dplistFiles = componentInfo[FW_INSTALLATION_XML_COMPONENT_DPLIST_FILES];
  panelFiles = componentInfo[FW_INSTALLATION_XML_COMPONENT_PANEL_FILES];
  scriptFiles = componentInfo[FW_INSTALLATION_XML_COMPONENT_SCRIPT_FILES];
  libraryFiles = componentInfo[FW_INSTALLATION_XML_COMPONENT_LIBRARY_FILES];
  otherFiles = componentInfo[FW_INSTALLATION_XML_COMPONENT_OTHER_FILES];
  xmlDesc = componentInfo[FW_INSTALLATION_XML_DESC_FILE];
  dontRestartProject = componentInfo[FW_INSTALLATION_XML_COMPONENT_DONT_RESTART];
  helpFile = componentInfo[FW_INSTALLATION_XML_COMPONENT_HELP_FILE];
  subComponents = componentInfo[FW_INSTALLATION_XML_COMPONENT_SUBCOMPONENTS];
  config_windows = componentInfo[FW_INSTALLATION_XML_COMPONENT_CONFIG_FILES];
  config_linux = componentInfo[FW_INSTALLATION_XML_COMPONENT_CONFIG_FILES]; 
  scriptsToBeAddedFiles = componentInfo[FW_INSTALLATION_XML_COMPONENT_SCRIPT_FILES];
  comments = componentInfo[FW_INSTALLATION_XML_COMPONENT_COMMENTS];
  
  return  0;
}

/** This function packs a component and saves it according to an xml description.

@param destinationFolder	path for the component package (does not need to exist)
@param xmlDesc						complete xml description (for experts)
@return 0 - component completely packed, -n - n component items not found
@author Sascha Schmeling
*/

int fwInstallation_packNgo(	string destinationFolder, dyn_string xmlDesc)
{
  fwInstallation_flagDeprecated("fwInstallation_packNgo", "fwInstallationPackager_packNgo");
  return fwInstallationPackager_packNgo(destinationFolder, PROJ_PATH, xmlDesc);
}	


/** This function allows to insert a manager into a project. 
The function is meant to be used in the init or postInstall scripts of a framework
component. It will popup a user interface asking whether to activate the manager if needed.

@param defActivated		FALSE - deactivated, TRUE - activated (if the user interface times out)
@param manTitle				title to be shown to the user
@param manager				name of the manager
@param startMode			{manual, once, always}
@param secKill				seconds to kill after stop
@param restartCount		number of restarts
@param resetMin				restart counter reset time (minutes)
@param commandLine		commandline for the manager
@return 1 - manager added, 2 - manager already existing, 3 - no user interface, 0 - manager addition failed
@author Sascha Schmeling
*/

int fwInstallation_appendManager(bool defActivated, string manTitle, 
				 string manager, string startMode, 
				 int secKill, int restartCount, int resetMin,
				 string commandLine)
{

  fwInstallation_flagDeprecated("fwInstallation_appendManager()", "fwInstallationManager_append()");  
  return fwInstallationManager_append(defActivated, manTitle, manager, startMode, secKill, restartCount, resetMin, commandLine); 
}


/** This function allows to insert a driver into a project. 
The function is meant to be used in the init or postInstall scripts of a framework
component. It will popup a user interface asking whether to activate the driver
or the corresponding simulator if needed.

@param defActivated		NONE - deactivated, {DRIVER,SIM} - activated the respective manager (if the user interface times out)
@param manTitle				title to be shown to the user
@param manager				name of the manager
@param startMode			{manual, once, always}
@param secKill				seconds to kill after stop
@param restartCount		number of restarts
@param resetMin				restart counter reset time (minutes)
@param commandLine		commandline for the manager
@return 1 - manager added, 2 - manager already existing, 3 - no user interface, 0 - manager addition failed
@author Sascha Schmeling
*/

int fwInstallation_appendDriver(string defActivated, string manTitle, 
																	string manager, string startMode, 
																	int secKill, int restartCount, int resetMin,
																	string commandLine)
{
  fwInstallation_flagDeprecated("fwInstallation_appendDriver()", "fwInstallationManager_appendDriver()");  
  return fwInstallationManager_appendDriver(defActivated, manTitle, manager, startMode, secKill, restartCount, resetMin, commandLine);
}


/** This function allows to insert a manager into a project. It is checked before, if the 
manager already exists.

@param manager				name of the manager
@param startMode			{manual, once, always}
@param secKill				seconds to kill after stop
@param restartCount		number of restarts
@param resetMin				restart counter reset time (minutes)
@param commandLine		commandline for the manager
@return 1 - manager added, 2 - manager already existing, 3 - manager addition disabled, 0 - manager addition failed
@author Sascha Schmeling
*/

int fwInstallation_addManager(string manager, string startMode, 
	    		      int secKill, int restartCount, int resetMin,
			      string commandLine)
{
  fwInstallation_flagDeprecated("fwInstallation_addManager()", "fwInstallationManager_add()");  
  return fwInstallationManager_add(manager, startMode, secKill, restartCount, resetMin, commandLine);
}

int fwInstallation_changeManagerSettings(string manager, string commandLine, string newCommandLine, string mode, int restart, int reset, int secKill) 
{
  fwInstallation_flagDeprecated("fwInstallation_changeManagerSettings()", "fwInstallationManager_setProperties()");  
  dyn_mixed managerInfo;
  
  managerInfo[FW_INSTALLATION_MANAGER_OPTIONS] = newCommandLine;
  managerInfo[FW_INSTALLATION_MANAGER_START_MODE] = mode;
  managerInfo[FW_INSTALLATION_MANAGER_RESTART_COUNT] = restart;
  managerInfo[FW_INSTALLATION_MANAGER_RESET_MIN] = reset;
  managerInfo[FW_INSTALLATION_MANAGER_SEC_KILL] = secKill;
  
  return fwInstallationManager_setProperties(manager, commandLine, managerInfo);
}

/** This function allows to find a manager in a project. 

@param manager				name of the manager
@param commandLine		commandline for the manager
@param startMode			{manual, once, always}
@return 1 - manager found, 2 manager not found, 0 - failed
@author Sascha Schmeling
*/

int fwInstallation_findManager(	string manager, string commandLine, string & startMode, int &managerPos)
{
  fwInstallation_flagDeprecated("fwInstallation_findManager()", "fwInstallationManager_getProperties()");  
  dyn_mixed managerInfo;
  fwInstallationManager_getProperties(manager, commandLine, managerInfo);
  startMode = managerInfo[FW_INSTALLATION_MANAGER_START_MODE];
  managerPos = managerInfo[FW_INSTALLATION_MANAGER_PMON_IDX];
  
  return 0;
}



/** This function retrieves all managers from pmon

@param err						error code
@param projName				name of the project, "" for own
@param manPos					position of the manager
@param manager				name of the manager
@param startMode			0 manual, 1 once, 2 always
@param secKill				seconds to kill after stop
@param restartCount		number of restarts
@param resetMin				restart counter reset time (minutes)
@param commandLine		commandline for the manager
@author Sascha Schmeling

*/
pmonGetManagers(bool &err, string projName,
								dyn_int &manPos, dyn_string &manager, dyn_int &startMode, 
								dyn_int &secKill, dyn_int &restartCount, dyn_int &resetMin,
								dyn_string &commandLine)
{
  fwInstallation_flagDeprecated("pmonGetManagers()", "fwInstallationManager_pmonGetManagers()");  
  string str, host;
	int port, iErr = paGetProjHostPort(projName, host, port);
	dyn_dyn_string dsResult;

	str = "##MGRLIST:LIST";
	
	err = pmon_query(str, host, port, dsResult, FALSE, TRUE);

	dynClear(manPos);
	dynClear(manager);
	dynClear(startMode);
	dynClear(secKill);
	dynClear(restartCount);
	dynClear(resetMin);
	dynClear(commandLine);
	
	if(dynlen(dsResult)>0)
		for(int i=1; i<=dynlen(dsResult); i++)
		{
			dynAppend(manPos, i);
			dynAppend(manager, 			dsResult[i][1]);
			dynAppend(startMode, 		dsResult[i][2]);
			dynAppend(secKill, 			dsResult[i][3]);
			dynAppend(restartCount,	dsResult[i][4]);
			dynAppend(resetMin,			dsResult[i][5]);
			if(dynlen(dsResult[i]) == 6)
				dynAppend(commandLine,	dsResult[i][6]);
			else
				dynAppend(commandLine,  "");
		}
}


/** This function will put together the specified section, that consists of several distributed parts.

@param section: string to define the section which will be compacted
@return 0 - "success"  -1 - error  -2 - section does not exist
@author S. Schmeling
*/

int fwInstallation_compactSection( string section )
{
  fwInstallation_flagDeprecated("fwInstallation_compactSection", "");  

	dyn_string configLines;
	int returnValue;
	returnValue = fwInstallation_getSection(section, configLines);
	if (returnValue == 0)
	{
		fwInstallation_clearSection(section);
		returnValue = fwInstallation_setSection(section, configLines);
		return returnValue;
	} else {
		return returnValue;
	}
	
}

// **************************************************************************************************************
// **************************************************************************************************************
//
//
// Functions related to the Component Installation
//
//
// **************************************************************************************************************
// **************************************************************************************************************




/** This function adds a library entry to a specified section of the config file.

@param section: string to define the section where the library has to be added (will be created if not existing)
@param libraryName: dyn_string containing the library names to be added
@return 0 - "success"  -1 - error 
@author S. Schmeling
*/

int fwInstallation_addLibrary( string section, dyn_string libraryName )
{
  fwInstallation_flagDeprecated("fwInstallation_addLibrary", "");  
  
	dyn_string configLines;
	
	dyn_int tempPositions;
	string tempLine;
	int i,j,k;
	bool sectionFound = FALSE;
	
	string configPath = getPath(CONFIG_REL_PATH);
	string configFile = configPath + "config";

	j = -1;

	if(dynlen(libraryName) > 0)
	{
		if(_fwInstallation_getConfigFile(configLines) == 0)
		{
			for (i=1; i<dynlen(configLines); i++)
			{
				tempLine = configLines[i];
				if(strpos(strltrim(strrtrim(tempLine)), "["+section+"]") == 0)
				{
					j = i;
					break;
				}
			}
			if(j > 0)
			{
				sectionFound = TRUE;
				for(k=dynlen(libraryName); k>0; k--)
				{
					tempLine = "LoadCtrlLibs = \"" + libraryName[k] + "\"";
					dynInsertAt(configLines,tempLine,j+1);
				}
			}
			if(sectionFound == TRUE)
			{
				return fwInstallation_saveFile(configLines, configFile);
			} else {
				return -2;
			}
		} else {
			return -1;
		}
	}
}

/**Deprecated function*/
int fwInstallation_getXml(string docPath, dyn_string &tags, dyn_string &values, dyn_anytype &attribs)
{
  fwInstallation_flagDeprecated("fwInstallation_getXml()", "fwInstallationXml_get()");
  return fwInstallationXml_get(docPath, tags, values, attribs);
}

/**Deprecated function */
int fwInstallation_getXmlTag(string docPath, string tag, dyn_string &FilteredValues, dyn_anytype &FilteredAttribs)
{
  fwInstallation_flagDeprecated("fwInstallation_getXmlTag()", "fwInstallationXml_getTag()");
  return fwInstallationXml_getTag(docPath, tag, FilteredValues, FilteredAttribs);
}

/** Deprecated function */
int fwInstallation_xmlChildNodesContent ( unsigned doc , int node ,
              dyn_string &node_names , dyn_anytype &attributes , dyn_string &nodevalues ,
              dyn_string &exceptionInfo )
{

  fwInstallation_flagDeprecated("fwInstallation_xmlChildNodesContent()", "fwInstallationXml_childNodesContent()");
  return fwInstallationXml_childNodesContent (doc, node,
              node_names, attributes, nodevalues,
              exceptionInfo);
}

/** Deprecated function */
int fwInstallation_shallStopManager(string managerType)
{
  fwInstallation_flagDeprecated("fwInstallation_shallStopManager()", "fwInstallationManager_shallStopManagersOfType()");
  return fwInstallationManager_shallStopManagersOfType(managerType);
}


/** Deprecated function */
int fwInstallation_stopManagers(dyn_string types)
{
  fwInstallation_flagDeprecated("fwInstallation_stopManagers()", "fwInstallationManager_stopAllOfTypes()");
  return fwInstallationManager_stopAllOfTypes(types);
}


/** Deprecated function */
int fwInstallation_logCurrentManagerConfiguration(string manager, string startMode, int secKill, 
  		                                  int restartCount, int resetMin, string commandLine)
{
  fwInstallation_flagDeprecated("fwInstallation_logCurrentManagerConfiguration()", "fwInstallationManager_logCurrentConfiguration()");
  return fwInstallationManager_logCurrentConfiguration(manager, startMode, secKill, restartCount, resetMin, commandLine);
}

/** Deprecated function */
int fwInstallation_getManagerIndex(string manager, string commandLine, int &pos)
{
  fwInstallation_flagDeprecated("fwInstallation_getManagerIndex()", "fwInstallationManager_getProperties()");
  dyn_mixed managerInfo;
  fwInstallationManager_getProperties(manager, commandLine, managerInfo);
  pos = managerInfo[FW_INSTALLATION_MANAGER_PMON_IDX];
  
  return 0;
}

/** Deprecated function */
int fwInstallation_setManagerMode(string manager, string commandLine, string mode)
{
  fwInstallation_flagDeprecated("fwInstallation_setManagerMode()", "fwInstallationManager_setMode()");
  return fwInstallationManager_setMode(manager, commandLine, mode);
}

/** Deprecated function */
int fwInstallation_executeAllManagerReconfigurationActions()
{
  fwInstallation_flagDeprecated("fwInstallation_executeAllManagerReconfigurationActions()", "fwInstallationManager_executeAllReconfigurationActions()");
  return fwInstallationManager_executeAllReconfigurationActions();
}

/** Deprecated function */
int fwInstallation_executeManagerReconfigurationAction(string manager, string startMode, int secKill, int restartCount, int resetMin, string commandLine)
{
  fwInstallation_flagDeprecated("fwInstallation_executeManagerReconfigurationAction()", "fwInstallationManager_executeReconfigurationAction()");
  return fwInstallationManager_executeReconfigurationAction(manager, startMode, secKill, restartCount, resetMin, commandLine);
}

/** Deprecated function */
int fwInstallation_getManagerReconfigurationActions(dyn_string &dsManager, dyn_string &dsStartMode, dyn_int &diSecKill, dyn_int &diRestartCount, dyn_int &diResetMin, dyn_string &dsCommandLine)
{  
  fwInstallation_flagDeprecated("fwInstallation_getManagerReconfigurationActions()", "fwInstallationManager_getReconfigurationActions()");
  return fwInstallationManager_getReconfigurationActions(dsManager, dsStartMode, diSecKill, diRestartCount, diResetMin, dsCommandLine);
}

/** Deprecated function */
int fwInstallation_setManagerReconfigurationActions(dyn_string dsManager, dyn_string dsStartMode, dyn_int diSecKill, dyn_int diRestartCount, dyn_int diResetMin, dyn_string dsCommandLine)
{
  fwInstallation_flagDeprecated("fwInstallation_setManagerReconfigurationActions()", "fwInstallationManager_setReconfigurationActions()");
  return fwInstallationManager_setReconfigurationActions(dsManager, dsStartMode, diSecKill, diRestartCount, diResetMin, dsCommandLine);
}

/** Deprecated function */
int fwInstallation_deleteManagerReconfigurationAction(string manager, string startMode, int secKill, int restartCount, int resetMin, string commandLine)
{
  fwInstallation_flagDeprecated("fwInstallation_deleteManagerReconfigurationAction()", "fwInstallationManager_deleteReconfigurationAction()");
  return fwInstallationManager_deleteReconfigurationAction(manager, startMode, secKill, restartCount, resetMin, commandLine);
}

int fwInstallation_getTagFromString(string & tagName, string & tagValue, string & strComponentFile)
{
  fwInstallation_flagDeprecated("fwInstallation_getTagFromString", "fwInstallationXml_getTagFromString()");
  return fwInstallationXml_getTagFromString(tagName, tagValue, strComponentFile);
}


/** Deprecated function */

int fwInstallation_loadProjPaths(dyn_string & proj_paths)
{
	fwInstallation_flagDeprecated("fwInstallation_loadProjPaths", "fwInstallation_getProjPaths()");
	int err = fwInstallation_getProjPaths(proj_paths);
  return err == 0;
}

/** Deprecated function */

int fwInstallationDB_getRemoteConnections(string systemName, string computerName, dyn_mixed &connectedSystemsInfo)
{
  fwInstallation_flagDeprecated("fwInstallationDB_getRemoteConnections", "fwInstallationDB_getSystemConnectivity()");
  return fwInstallationDB_getSystemConnectivity(systemName, computerName, connectedSystemsInfo, true);
}

/** ================================ **/
/** Deprecated config file functions **/
/** ================================ **/

/** This function reads the information from the componentConfigReduFile and copies it into the project config.redu file.
@param componentConfigReduFile: the name of a componentConfigFile
@param componentName: the name of a component
*//** Deprecated function */
fwInstallation_addComponentIntoConfigRedu(string componentConfigReduFile, string componentName)
{
  fwInstallation_flagDeprecated("fwInstallation_addComponentIntoConfigRedu", "fwInstallation_AddComponentIntoConfig()");
  
	string configFile = getPath(CONFIG_REL_PATH) + FW_INSTALLATION_CONFIG_FILE_NAME + ".redu";
	
	dyn_string loadedSections;  // this table contains the sections loaded from the config file
	dyn_dyn_string configSectionTable; // the memory representation of a config file     [1][i] - [section:parameter] , [i+1][j] - [value]
	dyn_string configLines; // this table contains the config file - each row contains one line from config file
	dynClear(loadedSections);
	configSectionTable [1] = "";
	configSectionTable [2] = "";
	configSectionTable [3] = "";

  if (!isfile(configFile))
  {
    file f = fopen(configFile, "w");
    fclose(f);
  
  } 
  else
  {  
  	// load the config file into its memory representation			
  	fwInstallation_loadConfigIntoTables(loadedSections, configSectionTable, configLines, configFile);
  }
  
  // add component into memory if not fwInstallation
  if(componentName != gFwInstallationComponentName)
  {
    fwInstallation_AddComponentIntoConfigIntoMemory(loadedSections, configSectionTable, configLines, componentConfigReduFile , componentName);
  }
        
	fwInstallation_saveFile(configLines, configFile);

}

/** This function reads the information from the component config file and saves the information into memory:
loadedSections and configSectionTable - the tables containing the information about the sections:parameters:values
configLines: the table containing the lines of a config file

@param loadedSections: the list of loaded sections
@param configSectionTable: the memory representation of a config file     [1][i] - [section:parameter] , [i+1][j] - [value]
@param configLines: the dyn_string containing the lines of a config file
@param fileName: the name of a config file of a component
@param componentName: the name of a component
@author M.Sliwinski
*//** Deprecated function */
int fwInstallation_AddComponentIntoConfigIntoMemory(dyn_string & loadedSections, dyn_dyn_string & configSectionTable, dyn_string & configLines, string fileName, string componentName)
{
  fwInstallation_flagDeprecated("fwInstallation_AddComponentIntoConfigIntoMemory", "fwInstallation_mergeComponentConfigIntoProject()");
  
	string fileInString;
	string tempLine;
	string currentSection = "NOT_YET_DEFINED";
	dyn_string componentLines; // contains the lines from the component config file
	dyn_dyn_string componentParameters; // [1][i] - section name; [i + 1][j] - section parameters ( lines )
	bool fileLoaded = false;
	dyn_string linesToAdd;
	string tempParameter;
	string tempValue;
	string tempString,tempStringQuotes;
	
	dyn_string strValues;
	dyn_string parameterValue;
	
	int idxOfSection;
	int sectionExistsInConfig;
	int valueExistsInConfig;
	int i, j , k;
	int returnValue;
	
	
//	componentParameters[1] = "";
//	componentParameters[2] = "";
	dynClear(componentParameters[1]);
	dynClear(componentParameters[2]);
	
	// first delete the old information about the component from the config file
	fwInstallation_deleteComponentFromConfigInMemory(loadedSections, configSectionTable, configLines, componentName);
		
	// load the component config file
	fileLoaded = fileToString(fileName, fileInString);
	
	if (! fileLoaded )
	{
		fwInstallation_throw("Cannot load " + fileName + " file", "error", 4);
	}
	else 
	{
			componentLines = fwInstallation_splitLines(fileInString);
			for(i = 1; i <= dynlen(componentLines); i++)
			{
				tempLine = strltrim(strrtrim(componentLines[i]));
				if (tempLine == "" )
				{
		//			Debug("\n The line is blank |"  + tempLine + "|");
				}
				else if ( strtok(tempLine, "#") == 0)
				{
					if( currentSection == "NOT_YET_DEFINED")
					{
						// we do not know in which section to add the comment
					}
					else  // add the comment into the table
					{
						idxOfSection = dynContains(componentParameters[1], currentSection);
						dynAppend(componentParameters[idxOfSection + 1], tempLine);
					}
				}
				else if ( strtok(tempLine, "[") == 0)  // this is a section
				{
					if(dynContains(componentParameters[1], tempLine) == 0)
					{ // add section only if it was not there
					  dynAppend(componentParameters[1] ,tempLine);
					}
					//else -> this section is already on the list, don't append it once again, entries will be merged with previous ones from same section
					currentSection = tempLine;
				}
				else // this is parametrization
				{
					 if(currentSection == "NOT_YET_DEFINED")
					 {
					 	fwInstallation_throw("the component file has errors  section is not defined. line: " + i);
					 }
					 else
					 {
					 	idxOfSection = dynContains(componentParameters[1], currentSection);
					 	//Debug("&&&&Parametrization: ", tempLine);
					 	dynAppend(componentParameters[idxOfSection + 1], tempLine);
					 }
				}
			} //end  for ( i = 1; i <= dynlen(componentLines)
			// the component information is now in the componentParameters table
		// adding the component into the config file
			for(i = 1; i <= dynlen(componentParameters[1]); i++)
			{
				currentSection = componentParameters[1][i];
		//		Debug("\n adding the lines in section: " + currentSection);
				
				sectionExistsInConfig = dynContains(loadedSections, currentSection);
				if(sectionExistsInConfig == 0) // the section does not exist - add the lines into the config table and into the memory
				{
					dynClear(linesToAdd);
							
					dynAppend(loadedSections, currentSection);
					dynAppend(configLines, currentSection);
					
					dynAppend(configLines, "#begin " + componentName);
					dynAppend(configLines, "#This should not be edited manually");
					dynAppend(configLines, "#if the component is empty it means that the parametrization is already done in the section");
          dynAppend(configLines, "#end " + componentName + "\n");

					for(j =1; j <= dynlen(componentParameters[i + 1]); j++)
					{
						tempLine = strltrim(strrtrim(componentParameters[i + 1][j]));
						
						if (tempLine == "")
						{
		//					 Debug("\n The line is blank: |" + tempLine + "|");
						}
						else if( strtok(tempLine, "#") == 0)
						{
		//					Debug("\n The line is a comment: |" + tempLine + "|");
							dynAppend(linesToAdd, tempLine);
						}
						else  // this line is a parametrization - check if the value already exist, if not add it
						{
								parameterValue = strsplit(tempLine, "=");
								tempParameter = strltrim(strrtrim(parameterValue[1]));
								tempValue = strltrim(strrtrim(parameterValue[2]));
								tempStringQuotes = tempValue; //SMS
								tempString = strltrim(strrtrim(tempValue, "\""), "\"");
								tempValue = tempString;
								strValues = strsplit(tempValue, ",");
                
								if(dynlen(strValues) == 0)//To handle config entry with the empty string value (e.g. exampleParam = "")
								{
									strValues = makeDynString("");
								}
								
								for(k = 1; k <= dynlen(strValues); k++)
								{
									tempValue = strltrim(strrtrim(strValues[k]));
									
									returnValue = fwInstallation_configContainsValue(configSectionTable, currentSection, tempParameter, tempValue);
									if( returnValue == 1)
									{
										// the value is already defined for this section and parameter
									}
									else
									{
										if(tempString == tempStringQuotes)	//SMS only if quotes where there before, put them again
										{
											dynAppend(linesToAdd, tempParameter + " = " + tempValue );	//SMS
										} else {
											dynAppend(linesToAdd, tempParameter + " = \"" + tempValue + "\"");	//SMS the original line
										}
		
										fwInstallation_addValueIntoMemory(configSectionTable, currentSection, tempParameter, tempValue); 
									}
								}	
						}

					}
					dynAppend(configLines, linesToAdd);
					dynAppend(configLines, "#end " + componentName + "\n");
					
					// we have added the whole information into the section			
				}
				else if(sectionExistsInConfig == -1)
				{
					Debug("\n ERROR: Cannot check if section exists in loadedSections table");
				}
				else // add the lines into the config table and into the memory
				{
					//Debug("&&&& 5 section exists in the config");
					if(dynlen(componentParameters) >= i+1)
					{
						dynClear(linesToAdd);
					 	dynAppend(linesToAdd, "#begin " + componentName);
						dynAppend(linesToAdd, "#This should not be edited manually");
						dynAppend(linesToAdd, "#if the component is empty it means that the parametrization is already done in the section");
						
						for(j = 1; j <= dynlen(componentParameters[i + 1]); j++)
						{
							tempLine = strltrim(strrtrim(componentParameters[i + 1][j]));			
							if (tempLine == "")
							{
			//					 Debug("\n The line is blank: |" + tempLine + "|");
							}
							else if( strtok(tempLine, "#") == 0)
							{
			//					Debug("\n The line is a comment: |" + tempLine + "|");
								dynAppend(linesToAdd, tempLine);
							}
							else  // this line is a parametrization - check if the value already exist, if not add it
							{
									parameterValue = strsplit(tempLine, "=");
									tempParameter = strltrim(strrtrim(parameterValue[1]));
									tempValue = strltrim(strrtrim(parameterValue[2]));
									
									tempStringQuotes = tempValue; //SMS
									tempString = strltrim(strrtrim(tempValue, "\""), "\"");
									tempValue = tempString;
									strValues = strsplit(tempValue, ",");
									
									for(k = 1; k <= dynlen(strValues); k++)
									{
										tempValue = strltrim(strrtrim(strValues[k]));
										
										returnValue = fwInstallation_configContainsValue(configSectionTable, currentSection, tempParameter, tempValue);
										if( returnValue == 1)
										{
											// the value is already defined for this section and parameter
										}
										else
										{
                                                                                        if(tempParameter == "distPeer")
                                                                                        {  
												dynAppend(linesToAdd, tempParameter + " = " + tempStringQuotes);	//SMS
                                                                                        }
											else if(tempString == tempStringQuotes)	//SMS only if quotes where there before, put them again
											{
												dynAppend(linesToAdd, tempParameter + " = " + tempValue );	//SMS
											} else {
												dynAppend(linesToAdd, tempParameter + " = \"" + tempValue + "\"");	//SMS the original line
											}
			
											fwInstallation_addValueIntoMemory(configSectionTable, currentSection, tempParameter, tempValue); 
										}
									}	
							}
						}
						dynAppend(linesToAdd, "#end " + componentName + "\n");
					}
		    // we are adding the lines - linesToAdd   into the configLines table under  - currentSection
					fwInstallation_addLinesIntoSection(configLines, currentSection, linesToAdd);
				}
			}
	}
}

/** This function adds [section:parameter] , [value] data into the memory representation of a config file

@param configSectionTable: the memory representation of a config file     [1][i] - [section:parameter] , [i+1][j] - [value]
@param section: the value of a section
@param parameter: the value of a parameter
@param value: the value of a "value"

@author M.Sliwinski
*//** Deprecated function */
int fwInstallation_addValueIntoMemory(dyn_dyn_string & configSectionTable, string section, string parameter, string value)
{
  fwInstallation_flagDeprecated("fwInstallation_addValueIntoMemory", "fwInstallation_config_addEntryIntoMemory()");
  
	int	idxSectionParam;
	int idxValue;
	int idxTemp;
	
	// get the index of section:parameter
	idxSectionParam = dynContains(configSectionTable[1], section + ":" + parameter);
	
	if (idxSectionParam == 0)
	{
		// add the section:parameter to the configSectionTable
		
		dynAppend(configSectionTable[1], section + ":" + parameter);
		
		// find the index of section:parameter
		idxTemp	= dynContains(configSectionTable[1], section + ":" + parameter);
		
		// add the value into memory
		dynAppend(configSectionTable[idxTemp + 1], value);	
	}
	else if(idxSectionParam == -1)
	{
		Debug("Error: fwInstallation_addValueIntoMemory");
		return -1;
	}
	else
	{
		idxValue = dynContains(configSectionTable[idxSectionParam + 1], value);
		
		if (idxValue == 0)
		{
			dynAppend(configSectionTable[idxSectionParam + 1], value);	
		}
		else if(idxValue == -1)
		{
			Debug("Error: fwInstallation_addValueIntoMemory");
		}
		else
		{	
			// This value already exists - do nothing
		}
	}
	return 1;

}

/** This function checks whether the section-parameter-value is defined in the memory
@param configSectionTable: the memory representation of a config file     [1][i] - [section:parameter] , [i+1][j] - [value]
@param section: the value of a section
@param parameter: the value of a parameter
@param value: the value of a "value"

@author M.Sliwinski
*//** Deprecated function */
int fwInstallation_configContainsValue(dyn_dyn_string & configSectionTable, string section , string parameter, string value)
{
  fwInstallation_flagDeprecated("fwInstallation_configContainsValue", "fwInstallation_config_entryExistsInMemory()");
  
	int idxOfParameter;
	int idxOfValue;
	
	idxOfParameter = dynContains(configSectionTable[1] , section + ":" + parameter);
	
	if(idxOfParameter == 0)
	{
//		Debug("\n fwInstallation_configContainsValue: There is no section_parameter:" + section + ":" + parameter);
		return 0;
	}
	else if (idxOfParameter == -1)
	{
		Debug("\n ERROR: fwInstallation_configContainsValue: error in checking section_parameter" );
		return 0;
	}
	else
	{	
		idxOfValue = dynContains(configSectionTable[idxOfParameter + 1], value);
		if(idxOfValue ==  0)
		{
			return 0;
		}
		else if (idxOfValue == -1)
		{
//			Debug("\n fwInstallation_configContainsValue: error in checking value" );
			return 0;
		}
		else
		{
//			Debug("\n fwInstallation_configContainsValue: value exists: returning 1");
			return 1;
		}
		
	}
}

/** This function deletes the config info about a component from the memory representation of a config file - [section:parameter] , [value]
and from the configLines dyn_string

@param loadedSections: the list of sections loaded from the config file
@param configSectionTable: the memory representation of a config file     [1][i] - [section:parameter] , [i+1][j] - [value]
@param configLines: the dyn_string containing the lines from the config file
@param componentName: the name of a component to be deleted

@author M.Sliwinski
*//** Deprecated function */
int fwInstallation_deleteComponentFromConfigInMemory(dyn_string & loadedSections, dyn_dyn_string & configSectionTable, dyn_string & configLines, string componentName)
{
  fwInstallation_flagDeprecated("fwInstallation_deleteComponentFromConfigInMemory", "");
  
	int i, j;
	
	int configLength;
	int idxSectionParam;
	int idxSection;
	int idxValue;
	int idxCurrent;
	int removeResult;
	
	string currentSection;
	dyn_string sections;
	dyn_string configSectionRow;
	
	string tempLine;
	string tempParameter;
	string tempValue;
	string tempString;
	string tempSection;
	dyn_string parameter_Value;
	
	dyn_dyn_int components; // [1][i] index of beginning of a component definition;  [2][i] index of ending of a component definition
	dyn_string strValues;
	
	int idxBegin = 0;
	int idxEnd = 0;
	
	dynClear(sections);
	dynClear(components[1]);
	dynClear(components[2]);
	


// find out where are the components situated and in which sections
// we are interested in the indexes of #begin and #end lines
	for(i = 1; i <= dynlen(configLines); i++)
	{
	
		if ( strtok(configLines[i], "[") == 0)
		{
						currentSection = configLines[i];
		}
		
			if(configLines[i] == "#begin " + componentName)
			{
				idxBegin = i;
			}
			
			if(configLines[i] == "#end " + componentName)
			{
				idxEnd = i;
			}
			
			if(idxBegin < idxEnd)
			{
				dynAppend(components[1], idxBegin); 
				dynAppend(components[2], idxEnd);
				dynAppend(sections, currentSection);

				idxBegin = 0;
				idxEnd = 0;
			}
	}


// delete the component from the file ( the configLines table ) and from configSectionTable

	for(i = dynlen(components[1]); i >=1; i--)
	{
		idxBegin = components[1][i];
		idxEnd = components[2][i];
	
		idxCurrent = idxEnd;

		currentSection = sections[i];

		for(idxCurrent = idxEnd; idxCurrent >= idxBegin; idxCurrent--)
		{
			// delete it from the configSectionTable
			tempLine = strltrim(strrtrim(configLines[idxCurrent]));
			removeResult = dynRemove(configLines, idxCurrent);
			if (removeResult == -1)
			{
				Debug("\n ERROR: fwInstallation_deleteComponentFromConfigInMemory(): could not remove the line from table");
			}
			
			if (tempLine == "" )
			{
			}
			else if ( strtok(tempLine, "#") == 0)
			{
			}
			else // the templine contains parameters
			{
				parameter_Value = strsplit(tempLine, "=");
				tempParameter = strltrim(strrtrim(parameter_Value[1]));
				tempValue = strltrim(strrtrim(parameter_Value[2]));
				tempString = strltrim(strrtrim(tempValue, "\""));
				tempValue = tempString;  // now value is without quotation marks
				strValues = strsplit(tempValue, ",");
				
				for(j = 1 ; j <= dynlen(strValues); j++)
				{
					tempValue = strValues[j];
					strValues[j] = strrtrim(strltrim(tempValue , "\" ") , "\" ");
				}
				
				tempString = currentSection + ":" + tempParameter;
				
				// Deleting the values from memory
				idxSectionParam = dynContains(configSectionTable[1], tempString);
					
				if(idxSectionParam == 0)
				{
				}
				else if (idxSectionParam == -1)
				{
					fwInstallation_throw("Cannot read value from configSectionTable: ");
				}
				else{
				
					for(j = 1; j <= dynlen(strValues); j++)
					{
						idxValue = dynContains(configSectionTable[idxSectionParam + 1], strValues[j]);
						
						if(idxValue > 0)
						{
							removeResult = dynRemove(configSectionTable[idxSectionParam + 1], idxValue);
						}					
					}

				} // else
			}
				
		}
		
	}
	
}

/** This function builds the memory representation of a config file

@param loadedSections: the list of sections loaded from the config file
@param configSectionTable: the memory representation of a config file     [1][i] - [section:parameter] , [i+1][j] - [value]
@param configLines: dyn_string containing the lines from the config file 
@param fileName: the name of a config file

@author M.Sliwinski
*//** Deprecated function */	
int fwInstallation_loadConfigIntoTables(dyn_string & loadedSections, dyn_dyn_string & configSectionTable, dyn_string & configLines, string fileName)
{
  fwInstallation_flagDeprecated("fwInstallation_loadConfigIntoTables", "fwInstallation_parseConfigFileLines()");
  
//	dyn_string knownSections = makeDynString("[ui]" , "[ctrl]");
	
	dyn_string parameter_Value;

	int idxSectionParam;
	int idxSection;
	int idxValue;
	int sectionLength;

	bool fileLoaded = false;

	string fileInString;

	string tempLine;
	string tempParameter;
	string tempValue;
	string tempString; 

	dyn_string strValues;
	
	string currentSection = "NOT_KNOWN";
	string lineTrimmed;
	
	int i, j ;
	
	fileLoaded = fileToString(fileName, fileInString);
	
	if (! fileLoaded )
	{
	
		fwInstallation_throw("Cannot load " + fileName + " file");
	}
	else 
	{
//		Debug("\n" + fileName + " - file loaded");
	}

	configLines = fwInstallation_splitLines(fileInString);
	
// each line is loaded in a row of dyn_string configLines
	
	for(i = 1; i <= dynlen(configLines); i++)
	{
		tempLine = strltrim(strrtrim(configLines[i]));

					
		if (tempLine == "" )
		{
//			Debug("\n The line is blank |"  + tempLine + "|");
		}
		else if ( strtok(tempLine, "#") == 0)
		{
//			Debug("\n This line is a comment |"  + tempLine + "|");
		}
		else if ( strtok(tempLine, "[") == 0)
		{
//			Debug("\n This line is a section |"  + tempLine + "|");
		//	if(dynContains(knownSections, tempLine))
		//	{
//						Debug("\n Adding new section into memory: " + tempLine);
			
					dynAppend(loadedSections ,tempLine);
					currentSection = tempLine;
					
		//	}
		//	else
		//	{
			//	Debug("\n This section is not known");
		//				currentSection = "NOT_KNOWN";
		//	}
		}
		else // this is parametrization
		{ 
			if (currentSection == "NOT_KNOWN")
			{
				// Debug("\n This section is not known: don't add parameter to memory");
			}
			else // This section is already in memory
			{
//				Debug("\n Adding the parameter into memory" + tempLine + "|");
				
				parameter_Value = strsplit(tempLine, "=");
				
				tempParameter = strltrim(strrtrim(parameter_Value[1]));
				
				tempValue = strltrim(strrtrim(parameter_Value[2]));
				
				tempString = strltrim(strrtrim(tempValue, "\""));
				
				tempValue = tempString;  // now value is without quotation marks
				
				strValues = strsplit(tempValue, ",");
				
				for(j = 1 ; j <= dynlen(strValues); j++)
				{
					tempValue = strValues[j];
					strValues[j] = strrtrim(strltrim(tempValue , "\" ") , "\" ");
				}
				
				// we hava all the values in a dyn_string - strValues
								
				idxSection = dynContains(loadedSections, currentSection);
				
				if (idxSection > 0)  // this section is in loaded sections
				{
				
					tempString = currentSection + ":" + tempParameter;
												
					idxSectionParam = dynContains(configSectionTable[1], tempString);
					
	//				Debug("\n idxSection : " + idxSection );
				
					if(idxSectionParam == 0)  // the parameter tempParameter is not defined
					{
						
						dynAppend(configSectionTable[1], tempString);
						
//						Debug("\n Adding parameter: " + tempString + " and values: " + strValues + "for the first time");
						
						idxSectionParam = dynContains(configSectionTable[1], tempString);
						
						for( j = 1; j<= dynlen(strValues); j++)
						{
							
							dynAppend(configSectionTable[idxSectionParam + 1], strValues[j]);
							
						}
							
	//					Debug("\n adding the parameter: " + tempParameter );			
					}
					else if( idxSectionParam == -1)
					{

					}
					else // the parameter is defined for the section add the value
					{
		
			
						for( j = 1; j<= dynlen(strValues); j++)
						{
									
							idxValue = dynContains(configSectionTable[idxSectionParam + 1], strValues[j]);
							
							if(idxValue == 0)
							{
								dynAppend(configSectionTable[idxSectionParam + 1], strValues[j]);
//								Debug("\n Adding parameter: " + tempString + " and values: " + strValues);
								
							}
							else if (idxValue == -1)
							{
								Debug("\n ERROR: fwInstallation_loadConfigIntoTables():  Error in adding Value into memory");
							}
							else
							{
//								Debug("\n This value already exists: " + tempValue);
							}
						}
					}
				} // if (dynContains(loadedSections, currentSection))
				else
				{	
					// This parameter is in a "not known section"
				}
				
			}
		
		} // else		
	} // end for	
        
        

}
