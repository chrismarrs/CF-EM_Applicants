<cfoutput>
    <table style="width:100%">
        <thead>
            <tr>
                <th style="width:30%">Name</th>
                <th style="width:50%" class="text-center">URL</th>
                <th>Enabled</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <cfloop array="#rc.positions#" index="position">
                <tr id="#position.id#">
                    <td class="name">#position.name#</td>
                    <td><a href="#position.URL#">http://#cgi.HTTP_HOST##position.URL#</a></td>
                    <td class="text-center"><input type="checkbox" class="cbEnable" #position.enabled?'checked':''#></td>
                    <td><button type="button" class="btnEdit">Edit</button></td>
                </tr>
            </cfloop>
        </tbody>
    </table>
    <cfif rc.canViewDebug>
        <div id="debug"></div>
    </cfif>
    <cfsavecontent variable = "rc.pageJS">
        <script>
            $(function(){
                $(".cbEnable").change(function(){
                    let positionId = $(this).closest('tr').attr("id");
                    $("##debug").html('');
                    $.post("#buildURL(".enable")#",{
                        returnformat: 'json',
                        positionId: positionId,
                        setEnabled: this.checked
                    })
                    .done(function(data, textStatus, jqXHR) {
                        let positionName = $("##" + data.positionId + " td.name").text();
                        console.log(positionName);
                    })
                    .fail(function(jqXHR, textStatus, errorThrown) {
                        $("##debug").html(jqXHR.responseText);
                    })
                });
                $(".btnEdit").click(function(){
                    let positionId = $(this).closest('tr').attr("id");
                    window.location = "#buildURL(".edit")#" + "/id/" + positionId;
                });
            });
        </script>
    </cfsavecontent>
</cfoutput>