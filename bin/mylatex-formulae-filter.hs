{-# LANGUAGE LambdaCase #-}
import Image.LaTeX.Render.Pandoc
import Image.LaTeX.Render
import Text.Pandoc.JSON

main :: IO ()
sharperDisplaymath = FormulaOptions "\\usepackage{amsmath}\\usepackage{amsfonts}\\usepackage{mathtools}" "displaymath" 200
sharperMath :: FormulaOptions
sharperMath = FormulaOptions "\\usepackage{amsmath}\\usepackage{amsfonts}\\usepackage{mathtools}\\usepackage{stmaryrd}" "math" 200
sharperPandocFormulaOptions :: PandocFormulaOptions
sharperPandocFormulaOptions = PandocFormulaOptions
  { shrinkBy = 2
  , errorDisplay = displayError
  , formulaOptions = \case DisplayMath -> sharperDisplaymath; _ -> sharperMath
  }
main = toJSONFilter $ convertFormulaDataURI defaultEnv sharperPandocFormulaOptions
