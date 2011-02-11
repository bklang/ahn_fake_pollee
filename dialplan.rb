fake_pollee {
  roll = rand(6)
  case roll
  when 0..2 then +ringforever
  when 3 then +machine
  when 4 then +answered
  when 5 then +congestion
  end
  hangup
}

ringforever {
  ahn_log.fake.info "Allowing call to ring indefinitely..."
  execute "Ringing"
  sleep 75
  hangup
}

congestion {
  ahn_log.fake.info "Congesting call"
  execute "Congestion"
}

machine {
  ahn_log.fake.info "Answering machine"
  execute "Ringing"
  sleep 3
  answer
  sleep 0.5
  play "demo-congrats"
  play "beep"
  hangup
}

answered {
  ahn_log.fake.info "Human answer"
  execute "Ringing"
  sleep 2
  answer
  sleep 0.5
  play "auth-thankyou"
  sleep 10
  while @call
    case rand(5)
    when 0..4 then ahn_log.fake.info "Sending digit 1"; execute "SendDTMF", "1"
    when 5 then ahn_log.fake.info "Giving up on poll"; hangup; raise Hangup
    end
    sleep 5
  end
  hangup
}
