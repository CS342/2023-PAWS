//
// This source file is part of the CS342 2023 PAWS Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import CardinalKit
import FHIR
import FHIRToFirestoreAdapter
import FirebaseAccount
import class FirebaseFirestore.FirestoreSettings
import FirestoreDataStorage
import FirestoreStoragePrefixUserIdAdapter
import HealthKit
import HealthKitDataSource
import HealthKitToFHIRAdapter
import PAWSMockDataStorageProvider
import PAWSSharedContext
import Questionnaires
import Scheduler
import SwiftUI


class PAWSAppDelegate: CardinalKitAppDelegate {
    override var configuration: Configuration {
        Configuration(standard: FHIR()) {
            if !FeatureFlags.disableFirebase {
                if FeatureFlags.useFirebaseEmulator {
                    FirebaseAccountConfiguration(emulatorSettings: (host: "localhost", port: 9099))
                } else {
                    FirebaseAccountConfiguration()
                }
                firestore
            }
            if HKHealthStore.isHealthDataAvailable() {
                healthKit
            }
            QuestionnaireDataSource()
            MockDataStorageProvider()

        }
    }
    
    
    private var firestore: Firestore<FHIR> {
        var firestoreSettings = FirestoreSettings()
        if FeatureFlags.useFirebaseEmulator {
            let settings = FirestoreSettings()
            settings.host = "localhost:8080"
            settings.isPersistenceEnabled = false
            settings.isSSLEnabled = false
        }
        
        return Firestore(
            adapter: {
                FHIRToFirestoreAdapter()
                FirestoreStoragePrefixUserIdAdapter()
            },
            settings: firestoreSettings
        )
    }
    
    
    private var healthKit: HealthKit<FHIR> {
        HealthKit {
            CollectSample(
                HKQuantityType(.heartRate),
                deliverySetting: .anchorQuery(.afterAuthorizationAndApplicationWillLaunch)
            )
            CollectSample(
                HKQuantityType(.heartRateVariabilitySDNN),
                deliverySetting: .anchorQuery(.afterAuthorizationAndApplicationWillLaunch)
            )
            CollectSample(
                HKQuantityType(.restingHeartRate),
                deliverySetting: .anchorQuery(.afterAuthorizationAndApplicationWillLaunch)
            )
            CollectSample(
                HKQuantityType.electrocardiogramType(),
                deliverySetting: .anchorQuery(.afterAuthorizationAndApplicationWillLaunch)
            )
        } adapter: {
            HealthKitToFHIRAdapter()
        }
    }
}
