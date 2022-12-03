function sb --wraps='watson stop --at (date -v-(random 5 7)M "+%H:%M") && watson restart' --description 'alias sb=watson stop --at (date -v-(random 5 7)M "+%H:%M") && watson restart'
	begin
		watson stop --at (date -v-7M "+%H:%M")
		watson restart -g
	end > ~/notification
end
