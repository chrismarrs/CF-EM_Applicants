<cfoutput>
    <p class="text-right">
        <button onclick="downloadAsExcel()">
            Export To Excel
            <img src="/assets/images/excel.gif">
        </button>
    </p>
    <table id="emailReport">
        <thead>
            <tr>
                <th>First Name</th>
                <th>Last Name</th>
                <th>City</th>
                <th>State</th>
                <th>Zip</th>
                <th>Email</th>
                <th>Send Date</th>
                <th>Email Name</th>
            </tr>
        <thead>
        <tbody>
            <cfloop array="#rc.emailMessages#" index="msg">
                <cfset applicant = msg.getApplicant() />
                <tr>
                    <td>#applicant.getFirstName()#</td>
                    <td>#applicant.getLastName()#</td>
                    <td>#applicant.getCity()#</td>
                    <td>#applicant.getState()#</td>
                    <td>#applicant.getZipCode()#</td>
                    <td>#applicant.getEmail()#</td>
                    <td>#dateFormat(msg.getSent(),"MM/DD/YYYY")#</td>
                    <td>#msg.getLetter().getName()#</td>
                </tr>
            </cfloop>
        </tbody>
    </table>
    <cfsavecontent variable = "rc.pageJS">
        <script>
            function downloadAsExcel(){
                window.location = "#buildURL(".excel")#?"
                    + "c=#rc.city#"
                    + "&sd=#rc.startDate#"
                    + "&ed=#rc.endDate#" ;
            }
        </script>
    </cfsavecontent>
</cfoutput>