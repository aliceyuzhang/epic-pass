Step 1:
You will need to change constants in spec/reserve_spec.rb line 4 - 7.

Step 2:
Install ruby gems in terminal:
```
bundle install
```

Step 3:
Run unit tests in this repo locally.

If you want to run it once in terminal:
```
bundle exec rspec
```

If you want to run it infinitely until you `ctrl+C` to kill it:
```
 (
 trap "exit" INT
 while true
   do
   bundle exec rspec

   sleep 1
   done
   ) &
     disown
```


Extra Info:
The default webdriver is set in spec/spec_helper.rb. It uses Chrome in incognito mode:
`config.default_driver = :selenium_chrome`
