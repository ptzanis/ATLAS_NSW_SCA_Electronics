int Busy = 0; 
 
dyn_dyn_string Dis_ids; 
dyn_string Children; 
dyn_int Indexes;
dyn_string Lunits; 
dyn_dyn_string Incompletes;
dyn_string ChildrenInc; 
dyn_string Refered, Reference;

synchronized FwDevMode_initialize(string domain, string device)
{ 
dyn_string objs, children, items, exInfo; 
int index, i, pos; 
string lunit, lunit_name; 
dyn_int lus, flags; 
string subdomain, subobj, child; 
int connectDone;
dyn_string connectChildren;

    while(Busy)  
	delay(0, 100);  
    Busy = 1;
//DebugTN("FwDevMode Initialize", domain, device);
    pos = strpos(device,"_FWDM"); 
    lunit = substr(device, 0, pos); 
    lunit_name = lunit; 
    if((pos = strpos(lunit,"/")) >= 0) 
        lunit_name = substr(lunit, pos+1);
    children = fwFsm_getLogicalUnitDevices(domain, lunit_name); 
    for(i = 1; i <= dynlen(children); i++) 
        dynAppend(lus,0); 
    objs = fwFsm_getLogicalUnitObjects(domain, lunit_name); 
    for(i = 1; i <= dynlen(objs); i++) 
    {
	  items = fwFsm_getObjChildren(domain, objs[i], flags); 
        if(dynlen(items)) 
            dynAppend(lus,1); 
        else 
            dynAppend(lus,0); 
    } 
    dynAppend(children, objs);
    if(index = dynContains(children, device)) 
    {
        dynRemove(children, index); 
        dynRemove(lus, index); 
    }
    dpSetWait(lunit+"_FWDM.n_devices",dynlen(children)); 
    dpSetWait(lunit+"_FWDM.disabled",makeDynString());  
    if(!(index = dynContains(Lunits, lunit))) 
    { 
        index = dynAppend(Lunits, lunit); 
        Dis_ids[index] = makeDynString(); 
        Incompletes[index] = makeDynString(); 
    }
//DebugTN("FwDevMode loop", domain, device, children);
    for(i = 1; i <= dynlen(children); i++) 
    {
        child = children[i];
        strreplace(child,"::","|");
        connectDone = 0;
        if(dynContains(Children, child))
          connectDone = 1;
        dynAppend(Children, child); 
        dynAppend(Indexes, index);
//DebugTN("FwDevMode connectEnabled", domain, children[i]);
        if(!connectDone)
        {
          dynAppend(connectChildren,children[i]);
//          fwUi_connectEnabled("change_state",domain, children[i]); 
        }
        if(lus[i]) 
        { 
            fwUi_connectDUModeBits("change_incomplete", domain, children[i], 0); 
        } 
/*
	  if(fwFsm_isAssociated(children[i]))  
        {
            subdomain = fwFsm_getAssociatedDomain(children[i]); 
            subobj = fwFsm_getAssociatedObj(children[i]); 
            if(subdomain != subobj) 
                fwUi_connectDUModeBits("change_reference", subdomain, subobj, 0);  
            else 
                fwUi_connectCUModeBits("change_reference", subdomain, subobj, 0, 0);    
DebugN("check ref",domain, children[i]);  
              dynAppend(Refered,subdomain+"|"+subobj); 
              dynAppend(Reference, domain+"|"+children[i]); 
        } 
*/
    } 
    for(i = 1; i <= dynlen(connectChildren); i++)
    {
//DebugTN("FwDevMode connecting", domain, lunit_name, connectChildren[i], Lunits, Indexes, Children);
      fwUi_connectEnabled("change_state",domain, connectChildren[i]); 
    }
//DebugTN("FwDevMode Out of Initialize", domain, device);
    Busy = 0;
}
 
change_state(string dp, int value) 
{ 
int n, index, lunit_index; 
dyn_string items;
string domain, id, lunit; 
int done = 0; 
 
    items = strsplit(dp,":|.");  
    domain = items[2];  
    id = items[3]; 
    if(items[4] != "mode") 
        id += "|"+items[4];
//DebugTN("FwDevMode change_state", dp, domain, id);

//DebugTN("FwDevMode Global Variables",Dis_ids,Children,Indexes,Lunits);

    while(Busy) 
	delay(0, 100); 
    Busy = 1; 
  
    compute(domain, id, value); 
    Busy = 0; 
} 
 
change_incomplete(string dp, bit32 value)  
{  
int n, index, lunit_index, inc;  
dyn_string items; 
string domain, id, lunit;  
int done = 0; 
bit32 bits;
  
    items = strsplit(dp,":|.");   
    domain = items[2];   
    id = items[3];  
    if(items[4] != "mode")  
        id += "|"+items[4]; 
  
    while(Busy)  
	    delay(0, 100);  
    Busy = 1; 
  
    inc = getBit(value, FwIncompleteDevBit);  
    compute(domain, id, !inc, "Tree"); 
    Busy = 0;  
} 
 
change_reference(string dp, bit32 value)   
{   
int n, index, lunit_index, inc;   
dyn_string items;  
string domain, id, lunit, obj;   
int done = 0;  
bit32 bits; 
   
    items = strsplit(dp,":|.");    
    domain = items[2];    
    id = items[3];   
    if(items[4] != "mode")   
        id += "|"+items[4];  
   
    while(Busy)   
	delay(0, 100);   
    Busy = 1;  
   
    if(strpos(domain, "fwCU_") == 0) 
    { 
        domain = substr(domain, 5); 
        id = domain; 
    } 
    if((index = dynContains(Refered, domain+"|"+id))) 
        obj = Reference[index];
DebugN(dp, domain, id, obj, value); 
//    inc = getBit(value, FwIncompleteDevBit);   
//    compute(domain, id, !inc, "Tree");  
    Busy = 0;   
}  
  

compute(string domain, string id, int value, string inv = "") 
{  
int index, lunit_index;
dyn_int lunit_indexes;   
string lunit;   
int i, done = 0;  
/* 
    index = dynContains(Children, id);  
    lunit_index = Indexes[index];  
*/
  for(i = 1; i <= dynlen(Children); i++)
  {
    if(Children[i] == id)
      dynAppend(lunit_indexes, Indexes[i]);
  }
//DebugTN("FwDevMode compute",domain, id, value, lunit_indexes, Lunits);
  for(i = 1; i <= dynlen(lunit_indexes); i++)
  {
    lunit_index = lunit_indexes[i];
  
//    dpGet(domain+"_FWDM.disabled", dis_ids);
    done = 0;
    id += inv;
    if(value == 1)  
    {  
        if(index = dynContains(Dis_ids[lunit_index], id))  
        { 
            dynRemove(Dis_ids[lunit_index], index);  
            done = 1;  
        }   
    }  
    else if(value == 0)
    {  
        if(!dynContains(Dis_ids[lunit_index], id))  
        {   
            dynAppend(Dis_ids[lunit_index], id);  
            done = 1;  
        }   
    }  
    else if(value == -1) 
    {   
        if(index = dynContains(Dis_ids[lunit_index], id))   
        {  
            dynRemove(Dis_ids[lunit_index], index);   
            done = 1;   
        }    
    }   
    if(done)
    { 
        lunit = Lunits[lunit_index];
//DebugTN("FwDevMode Setting dp",lunit+"_FWDM.disabled", Dis_ids[lunit_index]);
        dpSetWait(lunit+"_FWDM.disabled", Dis_ids[lunit_index]);   
    }
  }
}

FwDevMode_valueChanged( string domain, string device,
      dyn_string disabled, string &fwState )
{
	if (dynlen(disabled))
	{
		fwState = "DISABLED";
	}
	else 
	{
		fwState = "ENABLED";
	}
}



FwDevMode_doCommand(string domain, string device, string command)
{
}


