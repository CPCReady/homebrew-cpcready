brew untap CPCReady/cpcready && brew tap CPCReady/cpcready && brew install cpcready

brew install --build-from-source --verbose ./Formula/cpcready.rb  


Descarga repo homebrew-core
 git checkout -b cpcready  
 nano Formula/cpcready.rb
desde el repo brew tap --force homebrew/core
brew audit --new Formula/c/cpcready.rb
brew test cpcready
brew audit cpcready
brew style cpcready



 Have you followed the guidelines for contributing?
 Have you ensured that your commits follow the commit style guide?
 Have you checked that there aren't other open pull requests for the same formula update/change?
 Have you built your formula locally with HOMEBREW_NO_INSTALL_FROM_API=1 brew install --build-from-source <formula>, where <formula> is the name of the formula you're submitting?
 Is your test running fine brew test <formula>, where <formula> is the name of the formula you're submitting?
 Does your build pass brew audit --strict <formula> (after doing HOMEBREW_NO_INSTALL_FROM_API=1 brew install --build-from-source <formula>)? If this is a new formula, does it pass brew audit --new <formula>?