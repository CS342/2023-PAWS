//
// This source file is part of the CS342 2023 PAWS Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import CardinalKit
import FHIR
import HealthKit
import HealthKitDataSource
import HealthKitToFHIRAdapter
import PAWSMockDataStorageProvider
import PAWSSchedule
import Questionnaires
import Scheduler
import SwiftUI


class PAWSAppDelegate: CardinalKitAppDelegate {
    override var configuration: Configuration {
        Configuration(standard: FHIR()) {
            if HKHealthStore.isHealthDataAvailable() {
                HealthKit {
                    CollectSample(
                        HKQuantityType(.stepCount),
                        deliverySetting: .anchorQuery(.afterAuthorizationAndApplicationWillLaunch)
                    )
                } adapter: {
                    HealthKitToFHIRAdapter()
                }
            }
            QuestionnaireDataSource()
            MockDataStorageProvider()
            PAWSScheduler()
        }
    }
}