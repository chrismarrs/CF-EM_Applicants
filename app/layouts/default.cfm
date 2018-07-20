<cfparam name="rc.pageTitle" default="Enviro Master" />
<cfparam name="rc.pageJS" default="" />
<cfparam name="rc.subHeader" default="" />
<cfparam name="rc.entryPoint" default="app" />
<cfoutput>
    <html lang="en">
        <head>
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>#rc.pageTitle#</title>
            <link rel="stylesheet" href="/assets/bundles/#rc.entryPoint#.css?#URLEncodedFormat(application.vn)#">
            <script src="/assets/bundles/#rc.entryPoint#.js?#URLEncodedFormat(application.vn)#"></script>
        </head>
        <body>
            <header class="text-center">
                <img id="EM" src ="/assets/images/Enviro_Master.svg">
                #rc.subHeader#
            </header>
            #view(":partial/nav-menu")#
            #body#
            #rc.pageJS#
        </body>
    </html>
</cfoutput>