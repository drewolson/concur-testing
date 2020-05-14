module Main where

import Prelude hiding (div)
import Concur.Core.FRP (Signal, dyn, loopW)
import Concur.React (HTML)
import Concur.React.DOM (div, text)
import Concur.React.Props (onClick)
import Concur.React.Run (runWidgetInDom)
import Effect (Effect)

signal :: Signal HTML Int
signal =
  loopW 0 \i ->
    div
      [ i + 1 <$ onClick ]
      [ text $ "Count: " <> show i ]

main :: Effect Unit
main = do
  runWidgetInDom "signal" $ dyn signal
