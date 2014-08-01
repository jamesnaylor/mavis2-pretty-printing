on open these_items
	tell application "Finder"
		--set this_file to selection
		set this_file to these_items
		set this_file_alias to this_file as alias
		set name extension of this_file_alias to "html"
		set theFilePOSIX to POSIX path of this_file_alias
		-- display dialog theFilePOSIX
		
		set theUnixFile to quoted form of theFilePOSIX
		-- display dialog theUnixFile
		
		
		
		set this_story to read theFilePOSIX as «class utf8»
		-- display dialog this_story
		
		set this_story to my substitute({"“", "”", "‘", "’", "–", "…", "<html>"}, {"\"", "\"", "'", "'", "--", "...", "<html>

<head>
<style>
p {margin-left: 100px; margin-right: 50px; line-height:2.5em;}
</style>
</head>
"}, this_story)
		-- display dialog this_story
		my write_to_file(this_story, this_file_alias, false)
		
		
		-- set shellScript to ("/usr/bin/textutil -convert html " & theUnixFile)
		-- display alert shellScript
		-- do shell script shellScript
		
		-- set this_story to read theFilePOSIX as «class utf8»
		-- display dialog this_story
		
	end tell
	
	tell application "Safari"
		open this_file_alias
		activate
		try
			print document 1 with properties {copies:1} with print dialog
		end try
	end tell
	
	tell application "Finder" to move this_file_alias to trash
end open

on write_to_file(this_data, target_file, append_data)
	try
		set the target_file to the target_file as string
		set the open_target_file to open for access file target_file with write permission
		if append_data is false then set eof of the open_target_file to 0
		write this_data to the open_target_file starting at eof
		close access the open_target_file
		return true
	on error
		try
			close access file target_file
		end try
		return false
	end try
end write_to_file

on substitute(s, r, t)
	set s to s as list
	set r to r as list
	set t to t as text
	set tid to AppleScript's text item delimiters
	repeat with i from 1 to count s
		set AppleScript's text item delimiters to s's item i
		set t to t's text items
		set AppleScript's text item delimiters to r's item i
		set t to t as text
	end repeat
	set AppleScript's text item delimiters to tid
	return t
end substitute
