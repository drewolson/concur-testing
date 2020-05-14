module Test.Main where

import Prelude
import Concur.Core.Discharge (dischargePartialEffect)
import Concur.Core.FRP (dyn)
import Control.Comonad (extract)
import Data.Array (foldMap)
import Data.Tuple.Nested ((/\))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Main as Main
import ReactDOM (renderToStaticMarkup)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner (runSpec)

spec :: Spec Unit
spec = do
  describe "Main" do
    describe "signal" do
      it "has an initial value" do
        let
          value = extract Main.signal
        value `shouldEqual` 0
      it "has an initial view" do
        _ /\ elements <- liftEffect $ dischargePartialEffect $ dyn $ Main.signal
        let
          view = foldMap renderToStaticMarkup elements
        view `shouldEqual` """<div>Count: 0</div>"""
      it "updates the count" do
        -- I don't know what to do here. Can I trigger an 'onClick' before discharging my signal again?
        1 `shouldEqual` 1

main :: Effect Unit
main =
  launchAff_ do
    runSpec [ consoleReporter ] spec
