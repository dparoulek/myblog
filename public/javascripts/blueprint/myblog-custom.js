//**************
//Syntax Highlighter
//**************
$(document).ready(function(){
    SyntaxHighlighter.autoloader.apply(null, syntaxHighlighterPath(
	'applescript            @shBrushAppleScript.js',
	'actionscript3 as3      @shBrushAS3.js',
	'bash shell             @shBrushBash.js',
	'coldfusion cf          @shBrushColdFusion.js',
	'cpp c                  @shBrushCpp.js',
	'c# c-sharp csharp      @shBrushCSharp.js',
	'css                    @shBrushCss.js',
	'delphi pascal          @shBrushDelphi.js',
	'diff patch pas         @shBrushDiff.js',
	'erl erlang             @shBrushErlang.js',
	'groovy                 @shBrushGroovy.js',
	'java                   @shBrushJava.js',
	'jfx javafx             @shBrushJavaFX.js',
	'js jscript javascript  @shBrushJScript.js',
	'perl pl                @shBrushPerl.js',
	'php                    @shBrushPhp.js',
	'text plain             @shBrushPlain.js',
	'py python              @shBrushPython.js',
	'ruby rails ror rb      @shBrushRuby.js',
	'sass scss              @shBrushSass.js',
	'scala                  @shBrushScala.js',
	'sql                    @shBrushSql.js',
	'vb vbnet               @shBrushVb.js',
	'xml xhtml xslt html    @shBrushXml.js'
    ));
    SyntaxHighlighter.defaults['toolbar'] = false;
    SyntaxHighlighter.all();
});

    function syntaxHighlighterPath()
    {
	var args = arguments,
	    result = []
	;
	
	for(var i = 0; i < args.length; i++)
	    result.push(args[i].replace('@', '/javascripts/syntaxhighlighter_3.0.83/'));
	
	return result
    };
    

    //*****************
    // Renders Recaptcha Form Elements
    //*****************
    function showRecaptcha(public_key, element){
	Recaptcha.create(public_key, element, 
			 {
			     theme: "blackglass"
			 })
    }