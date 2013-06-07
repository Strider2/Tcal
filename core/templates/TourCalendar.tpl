<div class="container" style="margin-bottom:10px;">
<style>
table.calendar  { border-left:1px solid #999; }
tr.calendar-row {height:100px; }
tr.calendar-row:first-child {height:20px;  color:#FFF;}
td.calendar-day { min-height:160px; font-size:11px; position:relative; } * html div.calendar-day { height:80px; }
td.calendar-day:hover { background:#CCC; }
td.calendar-day-np { background:#eee; min-height:80px; } * html div.calendar-day-np { height:80px; }
td.calendar-day-head { background-color:#8a0602; font-weight:bold; text-align:center; width:120px; border-bottom:1px solid #999; border-top:1px solid #999; border-right:1px solid #999; }
div.day-number  { margin-left:110px; background:#999;  color:#fff; font-weight:bold; width:20px; text-align:center; margin-top:-50px;}/* shared */
td.calendar-day, td.calendar-day-np { width:120px; border-bottom:1px solid #999; border-right:1px solid #999; }
</style>
<?php
/* draws a calendar */
function draw_calendar($month,$year){

	/* draw table */
	$calendar = '<table cellpadding="0" cellspacing="0" class="calendar">';

	/* table headings */
	$headings = array('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
	$calendar.= '<tr class="calendar-row"><td class="calendar-day-head">'.implode('</td><td class="calendar-day-head">',$headings).'</td></tr>';

	/* days and weeks vars now ... */
	$running_day = date('w',mktime(0,0,0,$month,1,$year));
	$days_in_month = date('t',mktime(0,0,0,$month,1,$year));
	$days_in_this_week = 1;
	$day_counter = 0;
	$dates_array = array();

	/* row for week one */
	$calendar.= '<tr class="calendar-row">';

	/* print "blank" days until the first of the current week */
	for($x = 0; $x < $running_day; $x++):
		$calendar.= '<td class="calendar-day-np"> </td>';
		$days_in_this_week++;
	endfor;

	/* keep going with days.... */
	for($list_day = 1; $list_day <= $days_in_month; $list_day++):
		$calendar.= '<td class="calendar-day">';
			/* add in the day number */
			$calendar.= '<div class="day-number">'.$list_day.'</div>';
                        $events = EventsData::get_upcoming_events_dates();
                      echo $eventsdates;
                        if($list_day < 10){$list_day = "0".$list_day;}
                        $thisdate = date('Y') . "-" . date('m'). "-". $list_day;
                        $thedate = strtotime($thisdate);
                     	if($events != null){
                     	foreach($events as $events){
                     	if($events->date == $thisdate){
                         $calendar.= '<a href="'. SITE_URL .'/index.php/events/get_event?id='.$events->id.'"><span class="label label-info">' . $events->title. '</span></a>';
                        }}
                       }


			/** QUERY THE DATABASE FOR AN ENTRY FOR THIS DAY !!  IF MATCHES FOUND, PRINT THEM !! **/
			//$calendar.= str_repeat('<p> Test Text</p>',1);
			
		$calendar.= '</td>';
		if($running_day == 6):
			$calendar.= '</tr>';
			if(($day_counter+1) != $days_in_month):
				$calendar.= '<tr class="calendar-row">';
			endif;
			$running_day = -1;
			$days_in_this_week = 0;
		endif;
		$days_in_this_week++; $running_day++; $day_counter++;
	endfor;

	/* finish the rest of the days in the week */
	if($days_in_this_week < 8):
		for($x = 1; $x <= (8 - $days_in_this_week); $x++):
			$calendar.= '<td class="calendar-day-np"> </td>';
		endfor;
	endif;

	/* final row */
	$calendar.= '</tr>';

	/* end the table */
	$calendar.= '</table>';
	
	/* all done, return result */
	return $calendar;
}

function compareDates($date1,$date2) { 
$date1_array = explode("-",$date1); 
$date2_array = explode("-",$date2); 
$timestamp1 = 
mktime(0,0,0,$date1_array[1],$date1_array[2],$date1_array[0]); 
$timestamp2 = 
mktime(0,0,0,$date2_array[1],$date2_array[2],$date2_array[0]); 
if ($timestamp1=$timestamp2) { 
return true; 
} 
} 

/* sample usages */
$month = date('m');
$year = date('Y');
echo '<h3>' . date('F', mktime(0,0,0,$month,1)) . ' '. $year . '</h3>';
echo draw_calendar($month,$year);


?>
</div>