<cfparam name="rc.isNew" default ="false">
<cfoutput>
    <form class="position" action="#buildURL(".postEdit")#" method="Post">
        <input name="id" type="hidden" value="#rc.position.id#">
        <input name="deleted" type="hidden" value="#rc.position.deleted#">
        <fieldset>
            <legend>
                <label>Name <br><input type="text" id="name" name="name" value="#rc.position.name#"/></label>
            </legend>
        </fieldset>
        <fieldset>
            <legend>
                Enabled
            </legend>
            <label>Yes<input type="radio" id="enabledYes" value="1" name="enabled" #rc.position.enabled?'checked':''#></label>
            <label>No<input type="radio" id="enabledNo" value="0" name="enabled" #!rc.position.enabled?'checked':''#></label>
        </fieldset>
        <fieldset>
            <legend>
                <label for="descHTML">Display Text</label>
            </legend>
            <textarea id="descHTML" name="descHTML">#encodeForHTML(rc.position.descHTML)#</textarea>
        </fieldset>
        <fieldset>
            <input type="submit" name="submit" value="#rc.isNew?"Create":"Update"# Position">
        </fieldset>
    </form>
</cfoutput>
<cfsavecontent variable = "rc.pageJS">
    <script src="/assets/ckeditor/ckeditor.js"></script>
    <script>
        $(function(){
            CKEDITOR.replace('descHTML', {
			    extraPlugins: 'colorbutton,colordialog',
                contentsCss: '/assets/bundles/app.css'
            });
            $("#newPosition").submit(function(){
                let name = $("#name").val().trim();
                if(!name.length){
                    alert("Please enter a name for this position");
                    return false;
                }
            });
        });
    </script>
</cfsavecontent>