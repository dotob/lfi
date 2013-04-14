image
				name
				path
				type
				last_change
				last_visit
				
rails generate model Image name path type last_change:datetime last_visit:datetime

scan_path
				path
				interval
				active
				last_visit

rails generate model ScanPath path interval:integer active:boolean last_visit:datetime
