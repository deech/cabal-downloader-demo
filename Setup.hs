import Distribution.Simple
import Distribution.Simple.Setup
import Distribution.Types.GenericPackageDescription
import Distribution.Types.HookedBuildInfo
import Distribution.Types.LocalBuildInfo
import Distribution.Types.PackageDescription
import System.FilePath((</>))

import Network.HTTP.Download.File(downloadFile, Overwrite(..))

main :: IO ()
main = defaultMainWithHooks (simpleUserHooks { confHook = myConfHook })

myConfHook :: (GenericPackageDescription, HookedBuildInfo) -> ConfigFlags -> IO LocalBuildInfo
myConfHook (gpd, hbi) cflags = do
  _ <- downloadFile "https://tools.ietf.org/rfc/rfc8259.txt"
                    Nothing
                    "data-files"
                    "jsonrfc.txt"
                    (Overwrite True)
  let pd = packageDescription gpd
      dfs = dataFiles pd
      newGpd = gpd { packageDescription = pd { dataFiles = dfs ++ ["." </> "data-files" </> "jsonrfc.txt"]} }
  confHook simpleUserHooks (newGpd,hbi) cflags
