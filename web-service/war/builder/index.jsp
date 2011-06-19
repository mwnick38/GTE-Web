<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>GTE&#946;</title>
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
        	    <li class="active"><a title="GTE App" href="index.jsp">GTE App</a></li>
		    <li><a title="Documentation" href="documentation.jsp">Documentation</a></li>   
		    <li><a title="Installation" href="installation.jsp">Installation</a></li>            
		    <li><a title="Sample Games" href="sample.jsp">Sample Games</a></li> 
        	    <li><a title="FAQs" href="#">FAQs</a></li>
       		</ul>
    	</div>

    	<div id="maincont" class="clearfix" style="width: 100%; text-align: center; margin: auto;">




	<div id="GTEContainer" style="text-align: center; width: 100%; margin: auto; background-color: #B7BABC; padding: 2px 5px 5px 5px; border: 1px solid #808080;">
		<!-- <div style="background-color: #e0e0e0; border: #808080 solid 1px; font-size: 12px; padding: 3px 5px 3px 5px; font-family: Ubuntu; font-weight: bold;">Build</div> -->
		<div style="height: 750px">
			<div id="flashContent">				
				<p>
					To view this page ensure that Adobe Flash Player version 
					10.0.0 or greater is installed. 
				</p>
				<script type="text/javascript"> 
					var pageHost = ((document.location.protocol == "https:") ? "https://" :	"http://"); 
					document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
									+ pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
				</script>
				<noscript>
					<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="100%" id="GuiBuilder">
						<param name="movie" value="GuiBuilder-201106161214.swf" />
						<param name="quality" value="high" />
						<param name="bgcolor" value="white" />
						<param name="allowScriptAccess" value="sameDomain" />
						<param name="allowFullScreen" value="true" />
						<!--[if !IE]>-->
						<object type="application/x-shockwave-flash" data="GuiBuilder-201106161214.swf" width="100%" height="100%">
							<param name="quality" value="high" />
							<param name="bgcolor" value="white" />
							<param name="allowScriptAccess" value="sameDomain" />
							<param name="allowFullScreen" value="true" />
						<!--<![endif]-->
						<!--[if gte IE 6]>-->
							<p> 
								Either scripts and active content are not permitted to run or Adobe Flash Player version
								10.0.0 or greater is not installed.
							</p>
						<!--<![endif]-->
							<a href="http://www.adobe.com/go/getflashplayer">
								<img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash Player" />
							</a>
						<!--[if !IE]>-->
						</object>
						<!--<![endif]-->
					</object>
				</noscript>	
			</div>
		</div>
		<div id="solutionHeader" style="background-color: #00ff6b; color: #003300; border: #808080 solid 1px; font-size: 12px; padding: 3px 5px 3px 5px; font-family: Ubuntu; font-weight: bold; margin-top: 5px; display: none;">&#160;</div>
		<div id="solution" style="background-color: #ffffff; border: #808080 solid 1px; border-top: 0; font-size: 12px; padding: 3px 5px 3px 5px; display: none; overflow: auto;">		
		</div>
	</div>

	<div style="font-size: 10px; font-family: Ubuntu; text-align: left; width: 100%; margin: auto; background-color: #303030; color: #a0a0a0; padding: 3px 5px 3px 5px; border-left: 1px solid #303030; border-right: 1px solid #303030;">
	<div>Game Theory Explorer was developed by <span style="color: #ffffff;">Mark Egesdal</span> et al. Lemke algorithm and Sequence Form implementations adapted from the work of Bernhard von Stengel. Lrs algorithm implementation adapted from the work of David Avis. Lrs enumeration adapted from the work of Rahul Savani. Most icons courtesy of the Silk Icon Set created by Mark James.</div>
	

</div>

</div>
    
</body>
</html>
