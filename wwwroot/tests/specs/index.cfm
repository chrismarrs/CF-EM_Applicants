<cfscript>
    r = new testbox.system.TestBox( directory="tests/smoke" );
    WriteOutput(r.run());
</cfscript>