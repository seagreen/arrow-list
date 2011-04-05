{- |
The `ArrowKleisli' type class allows for embedding monadic operations in
Kleisli arrows.
-}
{-# LANGUAGE
    TypeOperators
  , MultiParamTypeClasses
  , FlexibleInstances
  , FunctionalDependencies
  #-}
module Control.Arrow.ArrowKleisli where

import Control.Arrow
import Control.Category
import Control.Monad.Trans
import Prelude hiding ((.), id, const)

class (Monad m, Arrow (~>)) => ArrowKleisli m (~>) | (~>) -> m where
  arrM :: (a -> m b) -> a ~> b

instance Monad m => ArrowKleisli m (Kleisli m) where
  arrM f = Kleisli f

arrIO :: (MonadIO m, ArrowKleisli m (~>)) => (a -> IO b) -> a ~> b
arrIO f = arrM (liftIO . f)

