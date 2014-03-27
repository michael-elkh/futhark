-- | C code generator.  This module can convert a well-typed L0
-- program to an equivalent C program.  It is assumed that the L0
-- program does not contain any arrays of tuples (use
-- "L0C.TupleTransform").  The C code is strictly sequential and leaks
-- memory like a sieve, so it's not very useful yet.
module L0C.Backends.SequentialC (compileProg) where

import Control.Monad

import Data.Loc

import L0C.InternalRep
import qualified L0C.FirstOrderTransform as FOT
import L0C.Tools

import qualified L0C.Backends.GenericC as GenericC

compileProg :: Prog -> String
compileProg = GenericC.compileProg expCompiler
  where expCompiler _ e
          | FOT.transformable e =
            liftM GenericC.CompileBody $ runBinder $ do
              es <- letTupExp "soac" =<< FOT.transformExp e
              return $ resultBody [] (map Var es) $ srclocOf e
          | otherwise           =
            return $ GenericC.CompileExp e
