



var fixtures = 
{
	"game0" : {
					"homeTeam":"Manchester United",
					"homeCrest":"http://pngimg.com/uploads/manchester_united/manchester_united_PNG26.png",
					"awayTeam": "Chelsea",
					"awayCrest":"http://www.stickpng.com/assets/images/580b57fcd9996e24bc43c4e1.png",
					"date":"Saturday 25th February",
					"kickOffTime":"14:05",
					"score":"0-0",
					"potValue":"",
					"betsForHomeTeam":"",
					"bestForAwayTeam":""

					},
	"game1" : {
					"homeTeam":"Leicester City",
					"homeCrest":"https://vignette.wikia.nocookie.net/logopedia/images/a/a4/Leicester_City_FC_logo.png/revision/latest?cb=20120208170529",
					"awayTeam": "Stoke City",
					"awayCrest":"http://www.stickpng.com/assets/images/580b57fcd9996e24bc43c4eb.png",
					"date":"Saturday 24th February",
					"kickOffTime":"12:30",
					"score":"0-0",
					"potValue":"",
					"betsForHomeTeam":"",
					"bestForAwayTeam":""


					},
	"game2" : {
					"homeTeam":"Liverpool Fc",
					"homeCrest":"https://vignette.wikia.nocookie.net/uncyclopedia/images/b/b2/Liverpool_FC_logo.png/revision/latest?cb=20060619221959",
					"awayTeam": "West Ham United",
					"awayCrest":"https://designfootball.com/design-galleries/football-crests/img-west-ham-unitedd-18050",
					"date":"Saturday 24th February",
					"kickOffTime":"15:00",
					"score":"0-0",
					"potValue":"",
					"betsForHomeTeam":"",
					"bestForAwayTeam":""

					},
	"game3" : {
					"homeTeam":"Arsenal",
					"homeCrest":"http://assets.stickpng.com/thumbs/580b57fcd9996e24bc43c4df.png",
					"awayTeam": "Manchester City",
					"awayCrest":"https://seeklogo.com/images/M/manchester-city-fc-new-logo-4C45133019-seeklogo.com.png",
					"date":"Thursday 1st March",
					"kickOffTime":"19:45",
					"score":"0-0",
					"potValue":"",
					"betsForHomeTeam":"",
					"bestForAwayTeam":""

					},
	"game4" : {
					"homeTeam":"Burnley",
					"homeCrest":"http://www.staldatestavernoxford.co.uk/wp-content/uploads/sites/42/2017/09/5878-burnley201718v2.png",
					"awayTeam": "Everton",
					"awayCrest":"http://www.stickpng.com/assets/images/580b57fcd9996e24bc43c4e3.png",
					"date":"Saturday 3rd March",
					"kickOffTime":"12:30",
					"score":"0-0",
					"potValue":"",
					"betsForHomeTeam":"",
					"bestForAwayTeam":""

					},
	"game5" : {
					"homeTeam":"West Brom",
					"homeCrest":"http://uefa.wdfiles.com/local--files/england:west-bromwich-albion-fc/west-bromwich-albion-fc.png",
					"awayTeam": "Burnley",
					"awayCrest":"http://www.asianimage.co.uk/resources/images/5957402/",
					"date":"Friday 24th February",
					"kickOffTime":"15:00",
					"score":"0-0",
					"potValue":"",
					"betsForHomeTeam":"",
					"bestForAwayTeam":""

					},
	"game6" : {
					"homeTeam":"Bournemouth",
					"homeCrest":"https://hdlogo.files.wordpress.com/2018/02/afc-bournemouth-logo-png1.png",
					"awayTeam": "Newcastle",
					"awayCrest":"http://www.stickpng.com/assets/images/580b57fcd9996e24bc43c4ec.png",
					"date":"Friday 24th February",
					"kickOffTime":"15:00",
					"score":"0-0",
					"potValue":"",
					"betsForHomeTeam":"",
					"bestForAwayTeam":""

					},

	"game7" : {
					"homeTeam":"Brighton",
					"homeCrest":"https://upload.wikimedia.org/wikipedia/en/thumb/f/fd/Brighton_%26_Hove_Albion_logo.svg/200px-Brighton_%26_Hove_Albion_logo.svg.png",
					"awayTeam": "Southhampton",
					"awayCrest":"https://upload.wikimedia.org/wikipedia/hif/8/85/FC_Southampton.png",
					"date":"Friday 24th February",
					"kickOffTime":"14:00",
					"score":"0-0",
					"potValue":"",
					"betsForHomeTeam":"",
					"bestForAwayTeam":""

					},

	"game8" : {
					"homeTeam":"Arsenal",
					"homeCrest":"http://assets.stickpng.com/thumbs/580b57fcd9996e24bc43c4df.png",
					"awayTeam": "Watford",
					"awayCrest":"http://www.stickpng.com/assets/images/580b57fcd9996e24bc43c4ef.png",
					"date":"Sunday 11th March",
					"kickOffTime":"13:30",
					"score":"0-0",
					"potValue":"",
					"betsForHomeTeam":"",
					"bestForAwayTeam":""

					},

	"game9" : {
					"homeTeam":"Stoke City",
					"homeCrest":"http://www.stickpng.com/assets/images/580b57fcd9996e24bc43c4eb.png",
					"awayTeam": "Manchester City",
					"awayCrest":"https://seeklogo.com/images/M/manchester-city-fc-new-logo-4C45133019-seeklogo.com.png",
					"date":"Monday 12th March",
					"kickOffTime":"20:00",
					"score":"0-0",
					"potValue":"",
					"betsForHomeTeam":"",
					"bestForAwayTeam":""

					},


					
}


var currentDisplayedMatch = "";
var selectedTeam ="";
var menuOut = false;




$(document).ready(function(){
	

	//click functions

    $("#hamburger").click(function()
	    {
    if(menuOut == false)
    {  
	    slideMenuOut();
	    
	}
    else
    {
    	slideMenuIn();
    	
    } 
    })
	
	

	$("#overlay").click(function(){
		slideMenuIn();
	})
       
     
	$(".checkBox").click(function(){
		clearAllCheckBoxes();
		$(this).css({"background-color":"#8BD2DC"})
		var boxChecked = $(this).attr("id");
		var boxId = parseInt(boxChecked.substring(8,boxChecked.lenth));
		console.log(boxId)
		changeGame(boxId);
	})


	$("#makeBetButton").click(function(){
		bringUpBettingScreen();
	})

	$("#xButton").click(function(){
		closeBettingScreen();
	})

	$("#homeCheckBox").click(function(){
		$("#awayCheckBox").css({"background-color":"white"})
		$(this).css({"background-color":"#89D2DD"});
		selectedTeam = fixtures[currentDisplayedMatch].homeTeam;
	})

	$("#awayCheckBox").click(function(){
		$("#homeCheckBox").css({"background-color":"white"})
		$(this).css({"background-color":"#89D2DD"});
		selectedTeam = fixtures[currentDisplayedMatch].awayTeam;
	})

	$("#betButton").click(function(){
		makeBet();
	})

	//Hover functions - put on style sheet



     $( "#sidebarSegment1,#sidebarSegment2,#sidebarSegment3,#sidebarSegment4,#sidebarSegment5" ).mouseover(function()
    	{
  			$( this ).css({"color": "white"});
		
		});  

	$( "#sidebarSegment1,#sidebarSegment2,#sidebarSegment3,#sidebarSegment4,#sidebarSegment5" ).mouseleave(function()
    	{
  			$( this).css({"color": "#57B497"});
		
		}); 



	$("#makeBetButton").mouseover(function(){
		$( "#makeBetButton" ).css({"color": "#57B497","background-color":"white"});
	})
	$("#makeBetButton").mouseleave(function(){
		$( "#makeBetButton" ).css({"color": "white","background-color":"#57B497"});
	})


     $("#betButton").mouseover(function(){
		$( this).css({"background-color":"#E1276F","color":"white"});
	})
	$("#betButton").mouseleave(function(){
		$(this).css({"background-color":"#57B497","color":"#dcf2f4 "});
	})       
})


function slideMenuOut()
{
	 $('#sidebar').animate({ left: "0"} , 700);
	 $('#overlay').css({"display":"inherit"})
	 menuOut = true;
	
}

function slideMenuIn()
{
	 $('#sidebar').animate({ left: "-23vw"} , 700);
	 $('#overlay').css({"display":"none"})
	 menuOut = false;
	
}


function clearAllCheckBoxes()
{
	$(".checkBox").css({"background-color":"#7C7676"})
	
}

function getCss(elmId, property){
   var elem = document.getElementById(elmId);
   return window.getComputedStyle(elem,null).getPropertyValue(property);
}

function changeGame(checkBoxTicked)
{
	checkBoxTicked = checkBoxTicked-1;
	var fixtureName = "game"+checkBoxTicked;
	currentDisplayedMatch = fixtureName;
	$("#crest1").attr("src",fixtures[fixtureName].homeCrest)
	$("#crest2").attr("src",fixtures[fixtureName].awayCrest)
	var date = fixtures[fixtureName].date;
	$("#date").text(date);
	var startTime = "Start Time : " + fixtures[fixtureName].kickOffTime;
	$("#startTime").text(startTime);
	
}

function bringUpBettingScreen()
{
	$("#darkOverlay").css({"display":"inherit"});
	$("#placeBetMenu").css({"display":"inherit"});
	$("#homeCrest").attr("src",fixtures[currentDisplayedMatch].homeCrest)
	$("#awayCrest").attr("src",fixtures[currentDisplayedMatch].awayCrest)
}

function closeBettingScreen()
{
	$("#darkOverlay").css({"display":"none"});
	$("#placeBetMenu").css({"display":"none"});
	selectedTeam = "";
	$("#ethInput").val("");
	$("#homeCheckBox").css({"background-color":"white"})
	$("#awayCheckBox").css({"background-color":"white"})
}

function makeBet()
{
	var ethValue = $("#ethInput").val();
	if(selectedTeam == "" || ethValue ==0 )
	{
		swal("This is not a valid bet")
	}
	else
	{
		
		 swal("Done!", "You have placed a bet for " +selectedTeam+" !", "success")
		 closeBettingScreen();
	}
}



