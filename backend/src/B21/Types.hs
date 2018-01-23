module B21.Types where

import Data.Aeson
import Data.Text ( Text, pack )
import Data.Time.Clock ( UTCTime(..) )
import Data.Time.Format
import GHC.Generics

newtype DateTime
  = DateTime { dateTime :: UTCTime }

data AddEmail
  = AddEmail
    { addEmailAddress :: Text
    }
    deriving (Generic, FromJSON, ToJSON)

data Event
  = Event
    { eventStart :: DateTime
    , eventEnd :: DateTime
    , eventTitle :: Text
    , eventSummary :: Text
    }

instance ToJSON Event where
  toJSON Event{..} = object
    [ "title" .= eventTitle
    , "summary" .= eventSummary
    , "startDate" .= eventStart
    , "endDate" .= eventEnd
    ]

iso8601 = iso8601DateFormat (Just "%H:%M:%SZ")

instance ToJSON DateTime where
  toJSON (DateTime t) = String $ pack (formatTime defaultTimeLocale iso8601 t)

data CreateTimesheet
  = CreateTimesheet
    { ctsName :: Text
    , ctsId :: Text
    , ctsDept :: Text
    , ctsSunday :: Text
    , ctsSaturday :: Text
    , ctsRate :: Double
    , ctsHours :: [Double]
      -- ^ Number of hours worked on Sunday, Monday, Tuesday, Wednesday,
      -- Thursday, Friday, Saturday.
    }
  deriving (Eq, Ord, Generic, FromJSON)

data TimesheetInfo
  = TimesheetInfo
    { timesheetUrl :: String
    }
  deriving (Generic, ToJSON)
