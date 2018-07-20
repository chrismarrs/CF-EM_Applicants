<cfscript>
    r = new testbox.system.TestBox( directory="tests/units" );
    WriteOutput(r.run());
</cfscript>