<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>GTE&#946;: Sample Games</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="language" content="en" />
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<link rel="stylesheet" type="text/css" media="screen" href="css/style.css" />
	<script src="swfobject.js" type="text/javascript"></script>
	<script type="text/javascript">
		<!-- For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. --> 
        var swfVersionStr = "10.0.0";
        <!-- To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
        var xiSwfUrlStr = "playerProductInstall.swf";
		var flashvars = {
			menum: "label=Lrs Find All Eq;toolTip=Lrs Find All Equilibria;type=nf;url=/matrix/",
		  	msolve: "label=Lemke NF Eq;toolTip=Lemke Find One Equilibrium;type=nf;url=/matrix/",   
	        xsolve: "label=Lemke SF Eq;toolTip=Lemke Find One Equilibrium (Sequence Form);type=xf;url=/tree/",			
	    };
	    
		var params = {
			menu: "false",
			scale: "noScale",
			allowFullscreen: "true",
			allowScriptAccess: "always",
			bgcolor: "#FFFFFF"			
		};
		var attributes = {
			id:"GuiBuilder"
		};
		swfobject.embedSWF(
			"GuiBuilder-201106161214.swf", 
			"flashContent", 
			"100%", 
			"100%", 
			swfVersionStr, 
			xiSwfUrlStr, 
			flashvars, 
			params, 
			attributes);
			
			
		function writeSolution(data)
		{
			var regex = /^SUCCESS/;
			var header = document.getElementById("solutionHeader");
			if (regex.test(data)) {
				header.style.backgroundColor = "#00ff6b";
			} else {
				header.style.backgroundColor = "#ff0000";
			}
			header.style.display  = "block";

			var body = document.getElementById("solution");
			body.style.display = "block";
			body.innerHTML = "<pre>" + data + "</pre>";
		}
	</script>


	<style type="text/css">
		.style1 {
			font-size: 40px;
			color: #FD3809;
			letter-spacing: -3px;
			}
		.style2 {
			color: #FF0000;
		}
		.style3 {
			color: #000000;
		}
	</style>


	<script type="text/javascript" src="js/script.js"></script>
	<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-23458684-2']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
</head>




<body>

<div id="container" class="clearfix">
	 
	<div id="headercont" style="width: 100%; text-align: center; margin: auto;">
    		<h1 class="style1">Game Theory Explorer<em class="style3">&#946;</em></h1>
        	<p><img style="display:inline; vertical-align: middle; border: #808080 solid 1px; margin: 5px 5px 5px 10px;" src="minitree_32x32.png" /><em>Build, explore and solve extensive form games.</em></p>
   	</div>
   	<div id="menucont" style="width: 100%; text-align: center; margin: auto;">
     	   	<ul>
		    <li></li>
        	    <li><a title="Gambit Home" href="http://www.gambit-project.org">Gambit Home</a></li>
        	    <li><a title="GTE App" href="index.jsp">GTE App</a></li>
		    <li><a title="Documentation" href="documentation.jsp">Documentation</a></li>   
		    <li><a title="Installation" href="installation.jsp">Installation</a></li>            
		    <li class="active"><a title="Sample Games" href="sample.jsp">Sample Games</a></li> 
        	    <li><a title="FAQs" href="#">FAQs</a></li>
       		</ul>
    	</div>

    <div id="maincont" class="clearfix" style="width: 100%; text-align: center; margin: auto;">
  
	<div id="GTEContainer" style="text-align: left; width: 100%; margin: auto; background-color: #FFFFFF; padding: 2px 5px 5px 5px; border: 1px solid #808080;">
		<!-- <div style="background-color: #e0e0e0; border: #808080 solid 1px; font-size: 12px; padding: 3px 5px 3px 5px; font-family: Ubuntu; font-weight: bold;">Build</div> -->
		<div>


			<br><br><h2 class="style1">Sample Games:</h2>
			<br><h4 class="style3">Right click -> <strong>Save As</strong>. Then, Open the .xml file with the GTE App.</h4><br>
			<ul>
				<li><a href="/ExampleGames/BattleOfTheSexes.xml">Battle of the Sexes</a></li>
				<li><a href="/ExampleGames/beer_quiche.xml">Beer or Quiche?</a></li>
				<li><a href="/ExampleGames/FudTir_Ex_3.5_Figure_3.15.xml">FudTir_Ex_3.5_Figure_3.15</a></li>
				<li><a href="/ExampleGames/FudTir_Sect_3.6_Fig_3.19.xml">FudTir_Sect_3.6_Fig_3.19</a></li>
				<li><a href="/ExampleGames/FudTir_Sec_4.3.2_Fig_4.2.xml">FudTir_Sec_4.3.2_Fig_4.2</a></li>
				<li><a href="/ExampleGames/GoingToWarAsSignal.xml">Going to War as a Signal</a></li>
				<li><a href="/ExampleGames/MoneyBurning.xml">Money Burning Game</a></li>
				<li><a href="/ExampleGames/PhDAdmissionsGame.xml">PhD Admissions Game</a></li>
				<li><a href="/ExampleGames/PrisonersDilemma.xml">Prisoners Dilemma</a></li>
			</ul>	<br><br>


        </div>
    </div>

			</div>
		</div>
		<div id="solutionHeader" style="background-color: #00ff6b; color: #003300; border: #808080 solid 1px; font-size: 12px; padding: 3px 5px 3px 5px; font-family: Ubuntu; font-weight: bold; margin-top: 5px; display: none;">&#160;</div>
		<div id="solution" style="background-color: #ffffff; border: #808080 solid 1px; border-top: 0; font-size: 12px; padding: 3px 5px 3px 5px; display: none; overflow: auto;">		
		</div>
    
</body>
</html>