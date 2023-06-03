.class public Lcom/adobe/air/AndroidGcmRegistrationService;
.super Landroid/app/IntentService;
.source "AndroidGcmRegistrationService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;
    }
.end annotation


# static fields
.field private static ACCESS_KEY:Ljava/lang/String; = null

.field private static APPLICATION_ARN:Ljava/lang/String; = null

.field private static final CUSTOM_USER_DATA:Ljava/lang/String; = "CustomUserData"

.field private static final ENABLED:Ljava/lang/String; = "Enabled"

.field private static final ENABLE_LOGGING:Ljava/lang/String; = "enableLogging"

.field private static final MAX_RETRIES:I = 0xa

.field private static final PROPERTY_APP_VERSION:Ljava/lang/String; = "appVersion"

.field private static final PROPERTY_ENDPOINT_ARN:Ljava/lang/String; = "endpointArn"

.field private static final RATE_LIMIT:Ljava/lang/String; = "rateLimit"

.field private static final RETRY_TIME:I = 0x493e0

.field private static SECRET_KEY:Ljava/lang/String; = null

.field private static SENDER_ID:Ljava/lang/String; = null

.field private static final TAG:Ljava/lang/String; = "AndroidGcmRegistrationService"

.field private static final TEST_ACCESS_KEY:Ljava/lang/String; = ""

.field private static final TEST_APPLICATION_ARN:Ljava/lang/String; = "arn:aws:sns:us-west-2:413177889857:app/GCM/airruntimetestapp"

.field private static final TEST_ENV:Ljava/lang/String; = "testEnv"

.field private static final TEST_SECRET_KEY:Ljava/lang/String; = ""

.field private static final TEST_SENDER_ID:Ljava/lang/String; = "1078258869814"

.field private static final TOKEN:Ljava/lang/String; = "Token"


# instance fields
.field private mClient:Lcom/amazonaws/services/sns/AmazonSNS;

.field private mEnableLogging:Z

.field private mEndpointArn:Ljava/lang/String;

.field private mGcm:Lcom/google/android/gms/gcm/GoogleCloudMessaging;

.field private mRegId:Ljava/lang/String;

.field private mResultReceiver:Landroid/os/ResultReceiver;

.field private mRetryCount:I

.field private mTestEnv:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 412
    const-string v0, "233437466354"

    sput-object v0, Lcom/adobe/air/AndroidGcmRegistrationService;->SENDER_ID:Ljava/lang/String;

    .line 413
    const-string v0, "arn:aws:sns:us-west-2:502492504188:app/GCM/AdobeAIRGCM"

    sput-object v0, Lcom/adobe/air/AndroidGcmRegistrationService;->APPLICATION_ARN:Ljava/lang/String;

    .line 414
    const-string v0, ""

    sput-object v0, Lcom/adobe/air/AndroidGcmRegistrationService;->ACCESS_KEY:Ljava/lang/String;

    .line 415
    const-string v0, ""

    sput-object v0, Lcom/adobe/air/AndroidGcmRegistrationService;->SECRET_KEY:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 70
    const-string v0, "AndroidGcmRegistrationService"

    invoke-direct {p0, v0}, Landroid/app/IntentService;-><init>(Ljava/lang/String;)V

    .line 422
    iput v2, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mRetryCount:I

    .line 423
    iput-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mRegId:Ljava/lang/String;

    .line 424
    iput-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEndpointArn:Ljava/lang/String;

    .line 425
    iput-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mClient:Lcom/amazonaws/services/sns/AmazonSNS;

    .line 426
    iput-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mGcm:Lcom/google/android/gms/gcm/GoogleCloudMessaging;

    .line 427
    iput-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mResultReceiver:Landroid/os/ResultReceiver;

    .line 428
    iput-boolean v2, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEnableLogging:Z

    .line 429
    iput-boolean v2, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mTestEnv:Z

    .line 71
    return-void
.end method

.method static synthetic access$100(Lcom/adobe/air/AndroidGcmRegistrationService;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AndroidGcmRegistrationService;

    .prologue
    .line 66
    iget-object v0, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mRegId:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$102(Lcom/adobe/air/AndroidGcmRegistrationService;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/AndroidGcmRegistrationService;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 66
    iput-object p1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mRegId:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$200()Ljava/lang/String;
    .locals 1

    .prologue
    .line 66
    sget-object v0, Lcom/adobe/air/AndroidGcmRegistrationService;->SENDER_ID:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$300(Lcom/adobe/air/AndroidGcmRegistrationService;)Lcom/google/android/gms/gcm/GoogleCloudMessaging;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AndroidGcmRegistrationService;

    .prologue
    .line 66
    iget-object v0, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mGcm:Lcom/google/android/gms/gcm/GoogleCloudMessaging;

    return-object v0
.end method

.method static synthetic access$400(Lcom/adobe/air/AndroidGcmRegistrationService;I)V
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/AndroidGcmRegistrationService;
    .param p1, "x1"    # I

    .prologue
    .line 66
    invoke-direct {p0, p1}, Lcom/adobe/air/AndroidGcmRegistrationService;->registerInBackground(I)V

    return-void
.end method

.method static synthetic access$500(Lcom/adobe/air/AndroidGcmRegistrationService;)V
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/AndroidGcmRegistrationService;

    .prologue
    .line 66
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->sendRegistrationIdToAws()V

    return-void
.end method

.method private checkPlayServices()Z
    .locals 3

    .prologue
    .line 99
    invoke-static {p0}, Lcom/google/android/gms/common/GooglePlayServicesUtil;->isGooglePlayServicesAvailable(Landroid/content/Context;)I

    move-result v0

    .line 100
    .local v0, "resultCode":I
    if-eqz v0, :cond_1

    .line 102
    invoke-static {v0}, Lcom/google/android/gms/common/GooglePlayServicesUtil;->isUserRecoverableError(I)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mResultReceiver:Landroid/os/ResultReceiver;

    if-eqz v1, :cond_0

    .line 104
    iget-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mResultReceiver:Landroid/os/ResultReceiver;

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Landroid/os/ResultReceiver;->send(ILandroid/os/Bundle;)V

    .line 110
    :cond_0
    const/4 v1, 0x0

    .line 112
    :goto_0
    return v1

    :cond_1
    const/4 v1, 0x1

    goto :goto_0
.end method

.method private configureTestEnv()V
    .locals 6

    .prologue
    const/high16 v5, -0x80000000

    .line 136
    :try_start_0
    new-instance v2, Landroid/content/ComponentName;

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-direct {v2, p0, v3}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 137
    .local v2, "serviceComponent":Landroid/content/ComponentName;
    invoke-virtual {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v3

    const/16 v4, 0x80

    invoke-virtual {v3, v2, v4}, Landroid/content/pm/PackageManager;->getServiceInfo(Landroid/content/ComponentName;I)Landroid/content/pm/ServiceInfo;

    move-result-object v3

    iget-object v0, v3, Landroid/content/pm/ServiceInfo;->metaData:Landroid/os/Bundle;

    .line 140
    .local v0, "bundle":Landroid/os/Bundle;
    if-nez v0, :cond_1

    .line 164
    .end local v0    # "bundle":Landroid/os/Bundle;
    .end local v2    # "serviceComponent":Landroid/content/ComponentName;
    :cond_0
    :goto_0
    return-void

    .line 143
    .restart local v0    # "bundle":Landroid/os/Bundle;
    .restart local v2    # "serviceComponent":Landroid/content/ComponentName;
    :cond_1
    const-string v3, "enableLogging"

    invoke-virtual {v0, v3}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v3

    iput-boolean v3, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEnableLogging:Z

    .line 144
    const-string v3, "testEnv"

    invoke-virtual {v0, v3}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v3

    iput-boolean v3, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mTestEnv:Z

    .line 145
    iget-boolean v3, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mTestEnv:Z

    if-eqz v3, :cond_0

    .line 147
    const-string v3, "1078258869814"

    sput-object v3, Lcom/adobe/air/AndroidGcmRegistrationService;->SENDER_ID:Ljava/lang/String;

    .line 148
    const-string v3, "arn:aws:sns:us-west-2:413177889857:app/GCM/airruntimetestapp"

    sput-object v3, Lcom/adobe/air/AndroidGcmRegistrationService;->APPLICATION_ARN:Ljava/lang/String;

    .line 149
    const-string v3, ""

    sput-object v3, Lcom/adobe/air/AndroidGcmRegistrationService;->ACCESS_KEY:Ljava/lang/String;

    .line 150
    const-string v3, ""

    sput-object v3, Lcom/adobe/air/AndroidGcmRegistrationService;->SECRET_KEY:Ljava/lang/String;

    .line 152
    const-string v3, "rateLimit"

    const/high16 v4, -0x80000000

    invoke-virtual {v0, v3, v4}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v1

    .line 153
    .local v1, "rateLimit":I
    if-eq v1, v5, :cond_0

    .line 155
    int-to-long v4, v1

    sput-wide v4, Lcom/adobe/air/AdobeAIRMainActivity;->RATE_LIMIT:J
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 160
    .end local v0    # "bundle":Landroid/os/Bundle;
    .end local v1    # "rateLimit":I
    .end local v2    # "serviceComponent":Landroid/content/ComponentName;
    :catch_0
    move-exception v3

    goto :goto_0
.end method

.method private getAppVersion()I
    .locals 6

    .prologue
    const/4 v2, 0x0

    .line 217
    :try_start_0
    invoke-virtual {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v3

    invoke-virtual {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getPackageName()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    invoke-virtual {v3, v4, v5}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v1

    .line 218
    .local v1, "packageInfo":Landroid/content/pm/PackageInfo;
    iget v2, v1, Landroid/content/pm/PackageInfo;->versionCode:I
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 223
    .end local v1    # "packageInfo":Landroid/content/pm/PackageInfo;
    :goto_0
    return v2

    .line 220
    :catch_0
    move-exception v0

    .line 223
    .local v0, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    goto :goto_0
.end method

.method private getCustomData()Ljava/lang/String;
    .locals 21

    .prologue
    .line 319
    :try_start_0
    new-instance v17, Lorg/json/JSONObject;

    invoke-direct/range {v17 .. v17}, Lorg/json/JSONObject;-><init>()V

    .line 320
    .local v17, "obj":Lorg/json/JSONObject;
    const-string v4, "osVersion"

    sget-object v5, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    move-object/from16 v0, v17

    invoke-virtual {v0, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 322
    invoke-virtual/range {p0 .. p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v4

    invoke-virtual/range {p0 .. p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getPackageName()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    invoke-virtual {v4, v5, v6}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v18

    .line 323
    .local v18, "packageInfo":Landroid/content/pm/PackageInfo;
    const-string v4, "airVersion"

    move-object/from16 v0, v18

    iget-object v5, v0, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;

    move-object/from16 v0, v17

    invoke-virtual {v0, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 325
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "&"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "&"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 326
    invoke-static/range {p0 .. p0}, Lcom/adobe/air/SystemCapabilities;->GetScreenHRes(Landroid/content/Context;)I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "&"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 327
    invoke-static/range {p0 .. p0}, Lcom/adobe/air/SystemCapabilities;->GetScreenVRes(Landroid/content/Context;)I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "&"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 328
    invoke-static/range {p0 .. p0}, Lcom/adobe/air/SystemCapabilities;->GetScreenDPI(Landroid/content/Context;)I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    .line 329
    .local v10, "deviceInfo":Ljava/lang/String;
    const-string v4, "deviceInfo"

    move-object/from16 v0, v17

    invoke-virtual {v0, v4, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 331
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v9

    .line 332
    .local v9, "defaultLocale":Ljava/util/Locale;
    const-string v4, "locale"

    invoke-virtual {v9}, Ljava/util/Locale;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v17

    invoke-virtual {v0, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 334
    sget-object v4, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v9, v4}, Ljava/util/Locale;->getDisplayCountry(Ljava/util/Locale;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v15

    .line 338
    .local v15, "location":Ljava/lang/String;
    :try_start_1
    const-string v4, "location"

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/adobe/air/AndroidGcmRegistrationService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v16

    check-cast v16, Landroid/location/LocationManager;

    .line 340
    .local v16, "locationManager":Landroid/location/LocationManager;
    const-string v4, "network"

    move-object/from16 v0, v16

    invoke-virtual {v0, v4}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result v13

    .line 343
    .local v13, "isNetworkEnabled":Z
    if-eqz v13, :cond_0

    .line 345
    const-string v4, "network"

    move-object/from16 v0, v16

    invoke-virtual {v0, v4}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object v14

    .line 346
    .local v14, "loc":Landroid/location/Location;
    new-instance v3, Landroid/location/Geocoder;

    sget-object v4, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    move-object/from16 v0, p0

    invoke-direct {v3, v0, v4}, Landroid/location/Geocoder;-><init>(Landroid/content/Context;Ljava/util/Locale;)V

    .line 347
    .local v3, "geocoder":Landroid/location/Geocoder;
    if-eqz v14, :cond_0

    if-eqz v3, :cond_0

    .line 349
    invoke-static {}, Landroid/location/Geocoder;->isPresent()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 351
    invoke-virtual {v14}, Landroid/location/Location;->getLatitude()D

    move-result-wide v4

    invoke-virtual {v14}, Landroid/location/Location;->getLongitude()D

    move-result-wide v6

    const/4 v8, 0x1

    invoke-virtual/range {v3 .. v8}, Landroid/location/Geocoder;->getFromLocation(DDI)Ljava/util/List;

    move-result-object v2

    .line 352
    .local v2, "addresses":Ljava/util/List;, "Ljava/util/List<Landroid/location/Address;>;"
    const/4 v4, 0x0

    invoke-interface {v2, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/location/Address;

    invoke-virtual {v4}, Landroid/location/Address;->getCountryName()Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v15

    .line 361
    .end local v2    # "addresses":Ljava/util/List;, "Ljava/util/List<Landroid/location/Address;>;"
    .end local v3    # "geocoder":Landroid/location/Geocoder;
    .end local v13    # "isNetworkEnabled":Z
    .end local v14    # "loc":Landroid/location/Location;
    .end local v16    # "locationManager":Landroid/location/LocationManager;
    :cond_0
    :goto_0
    :try_start_2
    const-string v4, "geo"

    move-object/from16 v0, v17

    invoke-virtual {v0, v4, v15}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 363
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-static {v4, v5}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v20

    .line 364
    .local v20, "timestamp":Ljava/lang/String;
    const-string v4, "timestamp"

    move-object/from16 v0, v17

    move-object/from16 v1, v20

    invoke-virtual {v0, v4, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 367
    invoke-virtual/range {p0 .. p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getApplicationContext()Landroid/content/Context;

    move-result-object v4

    invoke-static {v4}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v19

    .line 368
    .local v19, "prefs":Landroid/content/SharedPreferences;
    const-string v4, "AIRDefaultActivity"

    const/4 v5, 0x1

    move-object/from16 v0, v19

    invoke-interface {v0, v4, v5}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v12

    .line 369
    .local v12, "isGameListingDefaultActivity":Z
    if-eqz v12, :cond_1

    .line 371
    const-string v4, "AIRDefaultActivity"

    const-string v5, "GL"

    move-object/from16 v0, v17

    invoke-virtual {v0, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 378
    :goto_1
    invoke-virtual/range {v17 .. v17}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    .line 383
    .end local v9    # "defaultLocale":Ljava/util/Locale;
    .end local v10    # "deviceInfo":Ljava/lang/String;
    .end local v12    # "isGameListingDefaultActivity":Z
    .end local v15    # "location":Ljava/lang/String;
    .end local v17    # "obj":Lorg/json/JSONObject;
    .end local v18    # "packageInfo":Landroid/content/pm/PackageInfo;
    .end local v19    # "prefs":Landroid/content/SharedPreferences;
    .end local v20    # "timestamp":Ljava/lang/String;
    :goto_2
    return-object v4

    .line 375
    .restart local v9    # "defaultLocale":Ljava/util/Locale;
    .restart local v10    # "deviceInfo":Ljava/lang/String;
    .restart local v12    # "isGameListingDefaultActivity":Z
    .restart local v15    # "location":Ljava/lang/String;
    .restart local v17    # "obj":Lorg/json/JSONObject;
    .restart local v18    # "packageInfo":Landroid/content/pm/PackageInfo;
    .restart local v19    # "prefs":Landroid/content/SharedPreferences;
    .restart local v20    # "timestamp":Ljava/lang/String;
    :cond_1
    const-string v4, "AIRDefaultActivity"

    const-string v5, "PP"

    move-object/from16 v0, v17

    invoke-virtual {v0, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_1

    .line 380
    .end local v9    # "defaultLocale":Ljava/util/Locale;
    .end local v10    # "deviceInfo":Ljava/lang/String;
    .end local v12    # "isGameListingDefaultActivity":Z
    .end local v15    # "location":Ljava/lang/String;
    .end local v17    # "obj":Lorg/json/JSONObject;
    .end local v18    # "packageInfo":Landroid/content/pm/PackageInfo;
    .end local v19    # "prefs":Landroid/content/SharedPreferences;
    .end local v20    # "timestamp":Ljava/lang/String;
    :catch_0
    move-exception v11

    .line 383
    .local v11, "e":Ljava/lang/Exception;
    const-string v4, ""

    goto :goto_2

    .line 357
    .end local v11    # "e":Ljava/lang/Exception;
    .restart local v9    # "defaultLocale":Ljava/util/Locale;
    .restart local v10    # "deviceInfo":Ljava/lang/String;
    .restart local v15    # "location":Ljava/lang/String;
    .restart local v17    # "obj":Lorg/json/JSONObject;
    .restart local v18    # "packageInfo":Landroid/content/pm/PackageInfo;
    :catch_1
    move-exception v4

    goto :goto_0
.end method

.method private isAppRegistered()Z
    .locals 5

    .prologue
    const/high16 v4, -0x80000000

    .line 117
    invoke-virtual {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 122
    .local v1, "prefs":Landroid/content/SharedPreferences;
    const-string v3, "appVersion"

    invoke-interface {v1, v3, v4}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v2

    .line 123
    .local v2, "registeredVersion":I
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getAppVersion()I

    move-result v0

    .line 124
    .local v0, "currentVersion":I
    if-eq v2, v4, :cond_0

    if-eq v2, v0, :cond_1

    .line 127
    :cond_0
    const/4 v3, 0x0

    .line 129
    :goto_0
    return v3

    :cond_1
    const/4 v3, 0x1

    goto :goto_0
.end method

.method private registerForNotifications()V
    .locals 1

    .prologue
    .line 83
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->isAppRegistered()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 95
    :cond_0
    :goto_0
    return-void

    .line 86
    :cond_1
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->checkPlayServices()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 88
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->configureTestEnv()V

    .line 89
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/adobe/air/AndroidGcmRegistrationService;->registerInBackground(I)V

    goto :goto_0
.end method

.method private registerInBackground(I)V
    .locals 4
    .param p1, "sleepTime"    # I

    .prologue
    .line 169
    iget v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mRetryCount:I

    const/16 v2, 0xa

    if-ge v1, v2, :cond_2

    .line 171
    if-eqz p1, :cond_0

    .line 172
    iget v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mRetryCount:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mRetryCount:I

    .line 174
    :cond_0
    iget-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mGcm:Lcom/google/android/gms/gcm/GoogleCloudMessaging;

    if-nez v1, :cond_1

    .line 175
    invoke-static {p0}, Lcom/google/android/gms/gcm/GoogleCloudMessaging;->getInstance(Landroid/content/Context;)Lcom/google/android/gms/gcm/GoogleCloudMessaging;

    move-result-object v1

    iput-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mGcm:Lcom/google/android/gms/gcm/GoogleCloudMessaging;

    .line 177
    :cond_1
    new-instance v0, Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;-><init>(Lcom/adobe/air/AndroidGcmRegistrationService;Lcom/adobe/air/AndroidGcmRegistrationService$1;)V

    .line 178
    .local v0, "runner":Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;
    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Integer;

    const/4 v2, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-virtual {v0, v1}, Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    .line 180
    .end local v0    # "runner":Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;
    :cond_2
    return-void
.end method

.method private sendRegistrationIdToAws()V
    .locals 8

    .prologue
    .line 233
    :try_start_0
    new-instance v0, Lcom/amazonaws/auth/BasicAWSCredentials;

    sget-object v5, Lcom/adobe/air/AndroidGcmRegistrationService;->ACCESS_KEY:Ljava/lang/String;

    sget-object v6, Lcom/adobe/air/AndroidGcmRegistrationService;->SECRET_KEY:Ljava/lang/String;

    invoke-direct {v0, v5, v6}, Lcom/amazonaws/auth/BasicAWSCredentials;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 234
    .local v0, "credentials":Lcom/amazonaws/auth/AWSCredentials;
    sget-object v5, Lcom/amazonaws/regions/Regions;->US_WEST_2:Lcom/amazonaws/regions/Regions;

    invoke-static {v5}, Lcom/amazonaws/regions/Region;->getRegion(Lcom/amazonaws/regions/Regions;)Lcom/amazonaws/regions/Region;

    move-result-object v4

    .line 236
    .local v4, "region":Lcom/amazonaws/regions/Region;
    new-instance v5, Lcom/amazonaws/services/sns/AmazonSNSClient;

    invoke-direct {v5, v0}, Lcom/amazonaws/services/sns/AmazonSNSClient;-><init>(Lcom/amazonaws/auth/AWSCredentials;)V

    iput-object v5, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mClient:Lcom/amazonaws/services/sns/AmazonSNS;

    .line 237
    iget-object v5, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mClient:Lcom/amazonaws/services/sns/AmazonSNS;

    invoke-interface {v5, v4}, Lcom/amazonaws/services/sns/AmazonSNS;->setRegion(Lcom/amazonaws/regions/Region;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 241
    :try_start_1
    new-instance v2, Lcom/amazonaws/services/sns/model/CreatePlatformEndpointRequest;

    invoke-direct {v2}, Lcom/amazonaws/services/sns/model/CreatePlatformEndpointRequest;-><init>()V

    .line 242
    .local v2, "endpointRequest":Lcom/amazonaws/services/sns/model/CreatePlatformEndpointRequest;
    sget-object v5, Lcom/adobe/air/AndroidGcmRegistrationService;->APPLICATION_ARN:Ljava/lang/String;

    invoke-virtual {v2, v5}, Lcom/amazonaws/services/sns/model/CreatePlatformEndpointRequest;->setPlatformApplicationArn(Ljava/lang/String;)V

    .line 243
    iget-object v5, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mRegId:Ljava/lang/String;

    invoke-virtual {v2, v5}, Lcom/amazonaws/services/sns/model/CreatePlatformEndpointRequest;->setToken(Ljava/lang/String;)V

    .line 244
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getCustomData()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Lcom/amazonaws/services/sns/model/CreatePlatformEndpointRequest;->setCustomUserData(Ljava/lang/String;)V

    .line 246
    iget-object v5, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mClient:Lcom/amazonaws/services/sns/AmazonSNS;

    invoke-interface {v5, v2}, Lcom/amazonaws/services/sns/AmazonSNS;->createPlatformEndpoint(Lcom/amazonaws/services/sns/model/CreatePlatformEndpointRequest;)Lcom/amazonaws/services/sns/model/CreatePlatformEndpointResult;

    move-result-object v3

    .line 247
    .local v3, "endpointResponse":Lcom/amazonaws/services/sns/model/CreatePlatformEndpointResult;
    if-eqz v3, :cond_1

    invoke-virtual {v3}, Lcom/amazonaws/services/sns/model/CreatePlatformEndpointResult;->getEndpointArn()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_1

    .line 249
    invoke-virtual {v3}, Lcom/amazonaws/services/sns/model/CreatePlatformEndpointResult;->getEndpointArn()Ljava/lang/String;

    move-result-object v5

    iput-object v5, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEndpointArn:Ljava/lang/String;

    .line 250
    iget-boolean v5, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEnableLogging:Z

    if-eqz v5, :cond_0

    .line 251
    const-string v5, "AndroidGcmRegistrationService"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Creation EndpointArn = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEndpointArn:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 254
    :cond_0
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->updateSharedPref()V
    :try_end_1
    .catch Lcom/amazonaws/services/sns/model/InternalErrorException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Lcom/amazonaws/services/sns/model/InvalidParameterException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Lcom/amazonaws/AmazonServiceException; {:try_start_1 .. :try_end_1} :catch_4
    .catch Lcom/amazonaws/AmazonClientException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 280
    .end local v0    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .end local v2    # "endpointRequest":Lcom/amazonaws/services/sns/model/CreatePlatformEndpointRequest;
    .end local v3    # "endpointResponse":Lcom/amazonaws/services/sns/model/CreatePlatformEndpointResult;
    .end local v4    # "region":Lcom/amazonaws/regions/Region;
    :cond_1
    :goto_0
    return-void

    .line 257
    .restart local v0    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .restart local v4    # "region":Lcom/amazonaws/regions/Region;
    :catch_0
    move-exception v1

    .line 260
    .local v1, "e":Lcom/amazonaws/services/sns/model/InternalErrorException;
    const v5, 0x493e0

    :try_start_2
    invoke-direct {p0, v5}, Lcom/adobe/air/AndroidGcmRegistrationService;->registerInBackground(I)V

    goto :goto_0

    .line 276
    .end local v0    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .end local v1    # "e":Lcom/amazonaws/services/sns/model/InternalErrorException;
    .end local v4    # "region":Lcom/amazonaws/regions/Region;
    :catch_1
    move-exception v5

    goto :goto_0

    .line 262
    .restart local v0    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .restart local v4    # "region":Lcom/amazonaws/regions/Region;
    :catch_2
    move-exception v1

    .line 265
    .local v1, "e":Lcom/amazonaws/services/sns/model/InvalidParameterException;
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->updateEndpointAttributes()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    .line 271
    .end local v1    # "e":Lcom/amazonaws/services/sns/model/InvalidParameterException;
    :catch_3
    move-exception v5

    goto :goto_0

    .line 267
    :catch_4
    move-exception v5

    goto :goto_0
.end method

.method private updateEndpointAttributes()V
    .locals 6

    .prologue
    .line 287
    :try_start_0
    new-instance v1, Lcom/amazonaws/services/sns/model/SetEndpointAttributesRequest;

    invoke-direct {v1}, Lcom/amazonaws/services/sns/model/SetEndpointAttributesRequest;-><init>()V

    .line 288
    .local v1, "endpointAttributesRequest":Lcom/amazonaws/services/sns/model/SetEndpointAttributesRequest;
    iget-object v3, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEndpointArn:Ljava/lang/String;

    if-nez v3, :cond_0

    .line 290
    invoke-virtual {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    .line 291
    .local v2, "prefs":Landroid/content/SharedPreferences;
    const-string v3, "endpointArn"

    const-string v4, ""

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEndpointArn:Ljava/lang/String;

    .line 293
    iget-boolean v3, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEnableLogging:Z

    if-eqz v3, :cond_0

    .line 294
    const-string v3, "AndroidGcmRegistrationService"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Update EndpointArn = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEndpointArn:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 296
    .end local v2    # "prefs":Landroid/content/SharedPreferences;
    :cond_0
    iget-object v3, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEndpointArn:Ljava/lang/String;

    invoke-virtual {v1, v3}, Lcom/amazonaws/services/sns/model/SetEndpointAttributesRequest;->setEndpointArn(Ljava/lang/String;)V

    .line 297
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 298
    .local v0, "attributes":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    const-string v3, "CustomUserData"

    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getCustomData()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v0, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 299
    const-string v3, "Enabled"

    const-string v4, "true"

    invoke-interface {v0, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 300
    const-string v3, "Token"

    iget-object v4, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mRegId:Ljava/lang/String;

    invoke-interface {v0, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 301
    invoke-virtual {v1, v0}, Lcom/amazonaws/services/sns/model/SetEndpointAttributesRequest;->setAttributes(Ljava/util/Map;)V

    .line 302
    iget-object v3, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mClient:Lcom/amazonaws/services/sns/AmazonSNS;

    invoke-interface {v3, v1}, Lcom/amazonaws/services/sns/AmazonSNS;->setEndpointAttributes(Lcom/amazonaws/services/sns/model/SetEndpointAttributesRequest;)V

    .line 303
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->updateSharedPref()V
    :try_end_0
    .catch Lcom/amazonaws/AmazonServiceException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lcom/amazonaws/AmazonClientException; {:try_start_0 .. :try_end_0} :catch_0

    .line 313
    .end local v0    # "attributes":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v1    # "endpointAttributesRequest":Lcom/amazonaws/services/sns/model/SetEndpointAttributesRequest;
    :goto_0
    return-void

    .line 309
    :catch_0
    move-exception v3

    goto :goto_0

    .line 305
    :catch_1
    move-exception v3

    goto :goto_0
.end method

.method private updateSharedPref()V
    .locals 5

    .prologue
    .line 389
    invoke-virtual {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    .line 390
    .local v2, "prefs":Landroid/content/SharedPreferences;
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getAppVersion()I

    move-result v0

    .line 394
    .local v0, "appVersion":I
    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    .line 395
    .local v1, "editor":Landroid/content/SharedPreferences$Editor;
    const-string v3, "appVersion"

    invoke-interface {v1, v3, v0}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 396
    const-string v3, "endpointArn"

    iget-object v4, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEndpointArn:Ljava/lang/String;

    invoke-interface {v1, v3, v4}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 397
    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 398
    return-void
.end method


# virtual methods
.method protected onHandleIntent(Landroid/content/Intent;)V
    .locals 1
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    .line 77
    const-string v0, "resultReceiver"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Landroid/os/ResultReceiver;

    iput-object v0, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mResultReceiver:Landroid/os/ResultReceiver;

    .line 78
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->registerForNotifications()V

    .line 79
    return-void
.end method
