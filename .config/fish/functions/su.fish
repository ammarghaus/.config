function su --wraps='watson stop --at 09:15 && watson restart && watson add diversen +standup --from 09:15 --to (date "+%H:%M")' --description 'alias su=watson stop --at 09:15 && watson restart && watson add diversen +standup --from 09:15 --to (date "+%H:%M")'
	begin
		watson stop --at 09:15
		watson restart -g
		watson add diversen +standup --from 09:15 --to (date "+%H:%M")
	end > ~/notification
end
