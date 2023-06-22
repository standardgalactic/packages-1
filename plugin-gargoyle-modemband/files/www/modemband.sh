#!/usr/bin/haserl
<%
	# This program is copyright © 2023 Cezary Jackiewicz and is distributed under the terms of the GNU GPL
	# version 2.0 with a special clarification/exception that permits adapting the program to
	# configure proprietary "back end" software provided that all modifications to the web interface
	# itself remain covered by the GPL.
	# See http://gargoyle-router.com/faq.html#qfoss for more information

	eval $( gargoyle_session_validator -c "$COOKIE_hash" -e "$COOKIE_exp" -a "$HTTP_USER_AGENT" -i "$REMOTE_ADDR" -r "login.sh" -t $(uci get gargoyle.global.session_timeout) -b "$COOKIE_browser_time"  )
	gargoyle_header_footer -h -s "system" -p "modemband" -j "modemband.js" -z "modemband.js" -i 3ginfo
%>
<script>
	var firstrun = true;
</script>
<h1 class="page-header"><%~ modemband.Modembands %></h1>

<div class="row">

<div class="col-lg-6">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title"><%~ Device %></h3>
		</div>
	<div class="panel-body">

		<div class="row form-group" >
			<label id="list_device_label" for="list_device" class="col-xs-5" ><%~ Device %>:</label>
			<span class="col-xs-7">
			<select id="list_device" class="form-control" onchange='setDevice(this.value)' >
			<option value=''><%~ None %></option>
			<%
				devices=$(ls -1 /dev/tty[A\|U][C\|S]* 2>/dev/null)
				for d in $devices; do
					echo "<option value='$d'>$d</option>"
				done
			%>
			</select>
		    </span>
		</div>

	</div>
	</div>
</div>

<div id="modemerror" style="display:none;">
	<div class="col-lg-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><%~ Error %></h3>
			</div>

			<div class="panel-body">
				<em><span><%~ NoModem %>.</span></em>
			</div>
		</div>
	</div>
</div>

<div id="modemband1" style="display:none;">
<div class="col-lg-6">
<div class="panel panel-default">
<div class="panel-heading">
	<h3 class="panel-title"><%~ Info %></h3>
</div>
<div class="panel-body">
	<ul class="list-group">
	<div>
		<li class="list-group-item"><span class="list-group-item-title"><%~ Modem %>:</span><span id="modem">-</span></li>
	</div>
	</ul>
</div>
</div>
</div>
</div>

<div id="modemband2" style="display:none;">
<div class="col-lg-12">
<div class="panel panel-default">
<div class="panel-heading">
	<h3 class="panel-title"><%~ LTEBands %></h3>
</div>
<div class="panel-body">
	<ul class="list-group">
	<div id="modembandlte">
	</div>
	</ul>
</div>

</div>
</div>
</div>

</div>

<div id="bottom_button_container" class="panel panel-default">
	<button id="restart_button" class="btn btn-primary btn-lg" onclick="restartConn()"><%~ Restart %></button>
	<button id="default_button" class="btn btn-primary btn-lg" onclick="defaultData()"><%~ Default %></button>
	<button id="save_button" class="btn btn-primary btn-lg" onclick="saveChanges()"><%~ SaveChanges %></button>
	<button id="reset_button" class="btn btn-warning btn-lg" onclick="resetData()"><%~ Reset %></button>
</div>

<script>
<!--
	resetData();
//-->
</script>

<%
	gargoyle_header_footer -f -s "system" -p "modemband"
%>
