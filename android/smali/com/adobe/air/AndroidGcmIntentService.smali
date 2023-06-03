.class public Lcom/adobe/air/AndroidGcmIntentService;
.super Landroid/app/IntentService;
.source "AndroidGcmIntentService.java"


# static fields
.field private static final CLOUDFRONT:Ljava/lang/String; = "cloudfront"

.field private static final GAMESPACE:Ljava/lang/String; = "gamespace"

.field private static final GAME_URL:Ljava/lang/String; = "gameUrl"

.field private static final MSG_ID:Ljava/lang/String; = "msgId"

.field private static final PROPERTY_NOTIFICATION_TIMESTAMP:Ljava/lang/String; = "notficationTimestamp"

.field private static final TAG:Ljava/lang/String; = "AndroidGcmIntentService"

.field private static sUniqueId:I


# instance fields
.field private mGameDesc:Ljava/lang/String;

.field private mGameIconUrl:Ljava/lang/String;

.field private mGameTitle:Ljava/lang/String;

.field private mGameUrl:Ljava/lang/String;

.field private mGameUrlPrefix:Ljava/lang/String;

.field private mHost:Ljava/lang/String;

.field private mMsgId:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 233
    const/4 v0, 0x0

    sput v0, Lcom/adobe/air/AndroidGcmIntentService;->sUniqueId:I

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 49
    const-string v0, "AndroidGcmIntentService"

    invoke-direct {p0, v0}, Landroid/app/IntentService;-><init>(Ljava/lang/String;)V

    .line 226
    iput-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameTitle:Ljava/lang/String;

    .line 227
    iput-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameDesc:Ljava/lang/String;

    .line 228
    iput-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameIconUrl:Ljava/lang/String;

    .line 229
    iput-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameUrl:Ljava/lang/String;

    .line 230
    iput-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameUrlPrefix:Ljava/lang/String;

    .line 231
    iput-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mMsgId:Ljava/lang/String;

    .line 232
    iput-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mHost:Ljava/lang/String;

    .line 50
    return-void
.end method

.method private getBitmapFromURL(Ljava/lang/String;)Landroid/graphics/Bitmap;
    .locals 6
    .param p1, "src"    # Ljava/lang/String;

    .prologue
    .line 211
    :try_start_0
    new-instance v4, Ljava/net/URL;

    invoke-direct {v4, p1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 212
    .local v4, "url":Ljava/net/URL;
    invoke-virtual {v4}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v1

    check-cast v1, Ljava/net/HttpURLConnection;

    .line 213
    .local v1, "connection":Ljava/net/HttpURLConnection;
    const/4 v5, 0x1

    invoke-virtual {v1, v5}, Ljava/net/HttpURLConnection;->setDoInput(Z)V

    .line 214
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->connect()V

    .line 215
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v3

    .line 216
    .local v3, "input":Ljava/io/InputStream;
    invoke-static {v3}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 222
    .end local v1    # "connection":Ljava/net/HttpURLConnection;
    .end local v3    # "input":Ljava/io/InputStream;
    .end local v4    # "url":Ljava/net/URL;
    :goto_0
    return-object v0

    .line 219
    :catch_0
    move-exception v2

    .line 222
    .local v2, "e":Ljava/lang/Exception;
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private handleNotification(Ljava/lang/String;)V
    .locals 3
    .param p1, "message"    # Ljava/lang/String;

    .prologue
    .line 93
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmIntentService;->isNotificationValid()Z

    move-result v1

    if-nez v1, :cond_1

    .line 149
    :cond_0
    :goto_0
    return-void

    .line 100
    :cond_1
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 103
    .local v0, "obj":Lorg/json/JSONObject;
    const-string v1, "gameTitle"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameTitle:Ljava/lang/String;

    .line 106
    const-string v1, "gameDesc"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameDesc:Ljava/lang/String;

    .line 109
    const-string v1, "gameIconUrl"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameIconUrl:Ljava/lang/String;

    .line 112
    const-string v1, "gameUrl"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameUrl:Ljava/lang/String;

    .line 115
    const-string v1, "gameUrlPrefix"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameUrlPrefix:Ljava/lang/String;

    .line 118
    const-string v1, "msgId"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mMsgId:Ljava/lang/String;

    .line 121
    iget-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameTitle:Ljava/lang/String;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameDesc:Ljava/lang/String;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameIconUrl:Ljava/lang/String;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameUrl:Ljava/lang/String;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameUrlPrefix:Ljava/lang/String;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mMsgId:Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 127
    iget-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameUrlPrefix:Ljava/lang/String;

    const-string v2, "gamespace"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 129
    const-string v1, "http://gamespace.adobe.com"

    iput-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mHost:Ljava/lang/String;

    .line 138
    :cond_2
    :goto_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/adobe/air/AndroidGcmIntentService;->mHost:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameUrl:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameUrl:Ljava/lang/String;

    .line 139
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/adobe/air/AndroidGcmIntentService;->mHost:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameIconUrl:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameIconUrl:Ljava/lang/String;

    .line 143
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmIntentService;->sendNotification()V

    goto/16 :goto_0

    .line 145
    .end local v0    # "obj":Lorg/json/JSONObject;
    :catch_0
    move-exception v1

    goto/16 :goto_0

    .line 131
    .restart local v0    # "obj":Lorg/json/JSONObject;
    :cond_3
    iget-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameUrlPrefix:Ljava/lang/String;

    const-string v2, "cloudfront"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 133
    const-string v1, "https://dh8vjmvwgc27o.cloudfront.net"

    iput-object v1, p0, Lcom/adobe/air/AndroidGcmIntentService;->mHost:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1
.end method

.method private isNotificationValid()Z
    .locals 10

    .prologue
    const-wide/high16 v8, -0x8000000000000000L

    .line 189
    invoke-virtual {p0}, Lcom/adobe/air/AndroidGcmIntentService;->getApplicationContext()Landroid/content/Context;

    move-result-object v6

    invoke-static {v6}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v3

    .line 190
    .local v3, "prefs":Landroid/content/SharedPreferences;
    const-string v6, "notficationTimestamp"

    invoke-interface {v3, v6, v8, v9}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v4

    .line 191
    .local v4, "oldTime":J
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    .line 195
    .local v0, "currentTime":J
    cmp-long v6, v4, v8

    if-eqz v6, :cond_0

    sub-long v6, v0, v4

    sget-wide v8, Lcom/adobe/air/AdobeAIRMainActivity;->RATE_LIMIT:J

    cmp-long v6, v6, v8

    if-lez v6, :cond_1

    .line 199
    :cond_0
    invoke-interface {v3}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    .line 200
    .local v2, "editor":Landroid/content/SharedPreferences$Editor;
    const-string v6, "notficationTimestamp"

    invoke-interface {v2, v6, v0, v1}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    .line 201
    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 202
    const/4 v6, 0x1

    .line 204
    .end local v2    # "editor":Landroid/content/SharedPreferences$Editor;
    :goto_0
    return v6

    :cond_1
    const/4 v6, 0x0

    goto :goto_0
.end method

.method private sendNotification()V
    .locals 7

    .prologue
    .line 156
    new-instance v3, Landroid/content/Intent;

    const-class v5, Lcom/adobe/air/AdobeAIRMainActivity;

    invoke-direct {v3, p0, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 157
    .local v3, "notificationIntent":Landroid/content/Intent;
    const-string v5, "gameUrl"

    iget-object v6, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameUrl:Ljava/lang/String;

    invoke-virtual {v3, v5, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 158
    const-string v5, "msgId"

    iget-object v6, p0, Lcom/adobe/air/AndroidGcmIntentService;->mMsgId:Ljava/lang/String;

    invoke-virtual {v3, v5, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 159
    const/high16 v5, 0x24000000

    invoke-virtual {v3, v5}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 160
    sget v5, Lcom/adobe/air/AndroidGcmIntentService;->sUniqueId:I

    add-int/lit8 v5, v5, 0x1

    sput v5, Lcom/adobe/air/AndroidGcmIntentService;->sUniqueId:I

    const/high16 v6, 0x40000000    # 2.0f

    invoke-static {p0, v5, v3, v6}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v1

    .line 165
    .local v1, "intent":Landroid/app/PendingIntent;
    new-instance v2, Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-direct {v2, p0}, Landroid/support/v4/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;)V

    .line 166
    .local v2, "mBuilder":Landroid/support/v4/app/NotificationCompat$Builder;
    sget v5, Lcom/adobe/air/R$drawable;->icon:I

    invoke-virtual {v2, v5}, Landroid/support/v4/app/NotificationCompat$Builder;->setSmallIcon(I)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 167
    iget-object v5, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameTitle:Ljava/lang/String;

    invoke-virtual {v2, v5}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 168
    iget-object v5, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameDesc:Ljava/lang/String;

    invoke-virtual {v2, v5}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 169
    invoke-virtual {v2, v1}, Landroid/support/v4/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 170
    const/4 v5, 0x1

    invoke-virtual {v2, v5}, Landroid/support/v4/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 174
    iget-object v5, p0, Lcom/adobe/air/AndroidGcmIntentService;->mGameIconUrl:Ljava/lang/String;

    invoke-direct {p0, v5}, Lcom/adobe/air/AndroidGcmIntentService;->getBitmapFromURL(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 175
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    if-eqz v0, :cond_0

    .line 176
    invoke-virtual {v2, v0}, Landroid/support/v4/app/NotificationCompat$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/support/v4/app/NotificationCompat$Builder;

    .line 180
    :cond_0
    const-string v5, "notification"

    invoke-virtual {p0, v5}, Lcom/adobe/air/AndroidGcmIntentService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/app/NotificationManager;

    .line 181
    .local v4, "notificationManager":Landroid/app/NotificationManager;
    sget v5, Lcom/adobe/air/AndroidGcmIntentService;->sUniqueId:I

    invoke-virtual {v2}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v6

    invoke-virtual {v4, v5, v6}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 183
    return-void
.end method


# virtual methods
.method protected onHandleIntent(Landroid/content/Intent;)V
    .locals 5
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    .line 57
    const-string v2, ""

    .line 58
    .local v2, "message":Ljava/lang/String;
    invoke-virtual {p1}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    .line 59
    .local v0, "extras":Landroid/os/Bundle;
    if-eqz v0, :cond_0

    .line 61
    const-string v4, "message"

    invoke-virtual {v0, v4}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 63
    const-string v4, "message"

    invoke-virtual {v0, v4}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 68
    :cond_0
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_1

    .line 72
    invoke-static {p0}, Lcom/google/android/gms/gcm/GoogleCloudMessaging;->getInstance(Landroid/content/Context;)Lcom/google/android/gms/gcm/GoogleCloudMessaging;

    move-result-object v1

    .line 73
    .local v1, "gcm":Lcom/google/android/gms/gcm/GoogleCloudMessaging;
    invoke-virtual {v1, p1}, Lcom/google/android/gms/gcm/GoogleCloudMessaging;->getMessageType(Landroid/content/Intent;)Ljava/lang/String;

    move-result-object v3

    .line 75
    .local v3, "messageType":Ljava/lang/String;
    const-string v4, "gcm"

    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 77
    invoke-direct {p0, v2}, Lcom/adobe/air/AndroidGcmIntentService;->handleNotification(Ljava/lang/String;)V

    .line 86
    .end local v1    # "gcm":Lcom/google/android/gms/gcm/GoogleCloudMessaging;
    .end local v3    # "messageType":Ljava/lang/String;
    :cond_1
    invoke-static {p1}, Lcom/adobe/air/AndroidGcmBroadcastReceiver;->completeWakefulIntent(Landroid/content/Intent;)Z

    .line 87
    return-void
.end method
