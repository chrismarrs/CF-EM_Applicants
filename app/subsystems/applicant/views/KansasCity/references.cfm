<cfoutput>
    <cfset appText = rc.applicationText />
    <cfset references = rc.applicant.getReferences() />
    <form id="Utah-application" action="#buildURL(".postreferences")#" method="post" data-parsley-validate="">
        <article id="references">
            <header class="text-center">
                #appText.references.header#
                <br>
                <small>#appText.references.subHeader#</small>
            </header>
            <cfloop index = "i" from = "1" to = "#arrayLen(references)#">
                <section class="reference" data-reference-idx="#i#">
                    <input type="hidden" name="uuid#i#" value="#references[i].id#" />
                    <fieldset class="row">
                        <div class="col-md-8">
                            <label for="name#i#">#appText.references.name.label#</label>
                            <div id="name#i#Error"></div>
                        </div>
                        <div class="col-md-4">
                            <input type="text" id="name#i#" name="name#i#" required=""
                                value="#references[i].name#"
                                placeholder="#appText.references.name.placeholder#"
                                data-parsley-errors-container="##name#i#Error"
                                data-parsley-required-message="#appText.references.name.required#">
                        </div>
                    </fieldset>
                    <fieldset class="row">
                        <div class="col-md-8">
                            <label for="phone#i#">#appText.references.phone.label#</label>
                            <div id="phone#i#Error"></div>
                        </div>
                        <div class="col-md-4">
                            <input type="text" id="phone#i#" name="phone#i#" required=""
                                value="#references[i].phone#"
                                placeholder="#appText.references.phone.placeholder#"
                                data-parsley-pattern="^[\d\+\-\.\(\)\/\s]*$"
                                data-parsley-pattern-message="#appText.references.phone.pattern#"
                                data-parsley-errors-container="##phone#i#Error"
                                data-parsley-required-message="#appText.references.phone.required#">

                        </div>
                    </fieldset>
                    <fieldset class="row">
                        <div class="col-md-8">
                            <label for="relationship#i#">#appText.references.relationship.label#</label>
                            <div id="relationship#i#Error"></div>
                        </div>
                        <div class="col-md-4">
                            <input type="text" id="relationship#i#" name="relationship#i#" required=""
                                value="#references[i].relationship#"
                                placeholder="#appText.references.relationship.placeholder#"
                                data-parsley-errors-container="##relationship#i#Error"
                                data-parsley-required-message="#appText.references.relationship.required#">
                        </div>
                    </fieldset>
                    <hr>
                </section>
            </cfloop>
        </article>
        <div class="row">
            <div class="col-md-12 text-center">
                <input type="submit" name="submit" value="SUBMIT" />
            </div>
        </div>
    </form>
</cfoutput>
<!--- <cfsavecontent variable = "rc.pageJS">
    <script>
        $(function(){
            $(".reference").each(function(index, section){
                var referenceIdx = $(section).data("referenceIdx");
                if(referenceIdx === 1){
                    return;
                }
                $("#name"+referenceIdx).on("change", function(){
                    toggleReference(referenceIdx);
                });
                $("#name"+referenceIdx).trigger("change");
            });
        });

        function toggleReference(referenceIdx){
            if($("#name" + referenceIdx).val().length === 0){
                $("#name" + referenceIdx).removeAttr("required");
                $("#phone" + referenceIdx).removeAttr("required").trigger("input");
                $("#relationship" + referenceIdx).removeAttr("required").trigger("input");
            }
            else{
                $("#name" + referenceIdx).attr("required", "");
                $("#phone" + referenceIdx).attr("required", "").trigger("input");
                $("#relationship" + referenceIdx).attr("required", "").trigger("input");
            }

        }
    </script>
</cfsavecontent> --->