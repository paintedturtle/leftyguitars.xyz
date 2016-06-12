Number::millisecond = Number::milliseconds = -> @valueOf()
Number::second      = Number::seconds      = -> @milliseconds() * 1000
Number::minute      = Number::minutes      = -> @seconds() * 60
Number::hour        = Number::hours        = -> @minutes() * 60
