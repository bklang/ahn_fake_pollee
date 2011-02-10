fake_pollee {
  roll = rand(5)
  case roll
  when 0..1 then +congestion
  when 2..3 then +machine
  when 4 then +answered
  end
  hangup
}

congestion {
  execute "Congestion"
}

machine {
  execute "Ringing"
  sleep 3
  answer
  sleep 0.5
  play "demo-congrats"
  play "beep"
  hangup
}

answered {
  execute "Ringing"
  sleep 2
  answer
  sleep 0.5
  play "auth-thankyou"
  while @call
    case rand(5)
    when 0..4 then execute "SendDTMF", "1"
    when 5 then hangup
  end
  hangup
}
