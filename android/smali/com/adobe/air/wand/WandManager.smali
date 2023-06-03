.class public Lcom/adobe/air/wand/WandManager;
.super Ljava/lang/Object;
.source "WandManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/wand/WandManager$TaskListener;,
        Lcom/adobe/air/wand/WandManager$ViewListener;,
        Lcom/adobe/air/wand/WandManager$ConnectionListener;
    }
.end annotation


# static fields
.field private static final LOG_TAG:Ljava/lang/String; = "WandManager"


# instance fields
.field private mAccelerometer:Lcom/adobe/air/wand/motionsensor/Accelerometer;

.field private mDisplay:Landroid/view/Display;

.field private mGyroscope:Lcom/adobe/air/wand/motionsensor/Gyroscope;

.field private mHasFocus:Z

.field private mIsDisposed:Z

.field private mListenToConfigChange:Z

.field private mMagnetometer:Lcom/adobe/air/wand/motionsensor/Magnetometer;

.field private mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

.field private mProtocolVersion:Ljava/lang/String;

.field private mTaskManager:Lcom/adobe/air/wand/TaskManager;

.field private mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

.field private mVibrator:Landroid/os/Vibrator;

.field private mWandConnection:Lcom/adobe/air/wand/connection/Connection;

.field private mWandView:Lcom/adobe/air/wand/view/WandView;


# direct methods
.method public constructor <init>(Landroid/app/Activity;Lcom/adobe/air/wand/view/WandView;Lcom/adobe/air/wand/connection/Connection;)V
    .locals 11
    .param p1, "activity"    # Landroid/app/Activity;
    .param p2, "wandView"    # Lcom/adobe/air/wand/view/WandView;
    .param p3, "wandConnection"    # Lcom/adobe/air/wand/connection/Connection;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    const/4 v10, 0x0

    .line 249
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 227
    iput-object v10, p0, Lcom/adobe/air/wand/WandManager;->mWandConnection:Lcom/adobe/air/wand/connection/Connection;

    .line 228
    iput-object v10, p0, Lcom/adobe/air/wand/WandManager;->mWandView:Lcom/adobe/air/wand/view/WandView;

    .line 229
    iput-object v10, p0, Lcom/adobe/air/wand/WandManager;->mTaskManager:Lcom/adobe/air/wand/TaskManager;

    .line 231
    iput-object v10, p0, Lcom/adobe/air/wand/WandManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    .line 232
    iput-object v10, p0, Lcom/adobe/air/wand/WandManager;->mAccelerometer:Lcom/adobe/air/wand/motionsensor/Accelerometer;

    .line 233
    iput-object v10, p0, Lcom/adobe/air/wand/WandManager;->mMagnetometer:Lcom/adobe/air/wand/motionsensor/Magnetometer;

    .line 234
    iput-object v10, p0, Lcom/adobe/air/wand/WandManager;->mGyroscope:Lcom/adobe/air/wand/motionsensor/Gyroscope;

    .line 235
    iput-object v10, p0, Lcom/adobe/air/wand/WandManager;->mVibrator:Landroid/os/Vibrator;

    .line 236
    iput-object v10, p0, Lcom/adobe/air/wand/WandManager;->mDisplay:Landroid/view/Display;

    .line 237
    iput-object v10, p0, Lcom/adobe/air/wand/WandManager;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    .line 239
    iput-object v10, p0, Lcom/adobe/air/wand/WandManager;->mProtocolVersion:Ljava/lang/String;

    .line 241
    iput-boolean v0, p0, Lcom/adobe/air/wand/WandManager;->mIsDisposed:Z

    .line 242
    iput-boolean v0, p0, Lcom/adobe/air/wand/WandManager;->mHasFocus:Z

    .line 243
    iput-boolean v0, p0, Lcom/adobe/air/wand/WandManager;->mListenToConfigChange:Z

    .line 254
    invoke-static {p3}, Lcom/adobe/air/wand/ConnectionChangeReceiver;->resisterWandConnection(Lcom/adobe/air/wand/connection/Connection;)V

    .line 256
    iput-object p3, p0, Lcom/adobe/air/wand/WandManager;->mWandConnection:Lcom/adobe/air/wand/connection/Connection;

    .line 257
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager;->mWandConnection:Lcom/adobe/air/wand/connection/Connection;

    new-instance v1, Lcom/adobe/air/wand/WandManager$ConnectionListener;

    invoke-direct {v1, p0, v10}, Lcom/adobe/air/wand/WandManager$ConnectionListener;-><init>(Lcom/adobe/air/wand/WandManager;Lcom/adobe/air/wand/WandManager$1;)V

    invoke-interface {v0, v1}, Lcom/adobe/air/wand/connection/Connection;->registerListener(Lcom/adobe/air/wand/connection/Connection$Listener;)V

    .line 259
    iput-object p2, p0, Lcom/adobe/air/wand/WandManager;->mWandView:Lcom/adobe/air/wand/view/WandView;

    .line 260
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager;->mWandView:Lcom/adobe/air/wand/view/WandView;

    new-instance v1, Lcom/adobe/air/wand/WandManager$ViewListener;

    invoke-direct {v1, p0, v10}, Lcom/adobe/air/wand/WandManager$ViewListener;-><init>(Lcom/adobe/air/wand/WandManager;Lcom/adobe/air/wand/WandManager$1;)V

    invoke-interface {v0, v1}, Lcom/adobe/air/wand/view/WandView;->registerListener(Lcom/adobe/air/wand/view/WandView$Listener;)V

    .line 272
    new-instance v0, Lcom/adobe/air/wand/message/json/JSONMessageManager;

    invoke-direct {v0}, Lcom/adobe/air/wand/message/json/JSONMessageManager;-><init>()V

    iput-object v0, p0, Lcom/adobe/air/wand/WandManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    .line 274
    invoke-interface {p2}, Lcom/adobe/air/wand/view/WandView;->getTouchSensor()Lcom/adobe/air/wand/view/TouchSensor;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/wand/WandManager;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    .line 276
    new-instance v0, Lcom/adobe/air/wand/motionsensor/Accelerometer;

    invoke-direct {v0, p1}, Lcom/adobe/air/wand/motionsensor/Accelerometer;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/adobe/air/wand/WandManager;->mAccelerometer:Lcom/adobe/air/wand/motionsensor/Accelerometer;

    .line 278
    new-instance v0, Lcom/adobe/air/wand/motionsensor/Magnetometer;

    invoke-direct {v0, p1}, Lcom/adobe/air/wand/motionsensor/Magnetometer;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/adobe/air/wand/WandManager;->mMagnetometer:Lcom/adobe/air/wand/motionsensor/Magnetometer;

    .line 280
    new-instance v0, Lcom/adobe/air/wand/motionsensor/Gyroscope;

    invoke-direct {v0, p1}, Lcom/adobe/air/wand/motionsensor/Gyroscope;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/adobe/air/wand/WandManager;->mGyroscope:Lcom/adobe/air/wand/motionsensor/Gyroscope;

    .line 282
    const/4 v8, 0x0

    .line 284
    .local v8, "wandContext":Landroid/content/Context;
    move-object v8, p1

    if-nez p1, :cond_0

    .line 285
    new-instance v0, Ljava/lang/Exception;

    const-string v1, "Cannot find application context while initializing."

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 288
    :cond_0
    const-string v0, "vibrator"

    invoke-virtual {v8, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/Vibrator;

    iput-object v0, p0, Lcom/adobe/air/wand/WandManager;->mVibrator:Landroid/os/Vibrator;

    .line 290
    const-string v0, "window"

    invoke-virtual {v8, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Landroid/view/WindowManager;

    .line 291
    .local v9, "wm":Landroid/view/WindowManager;
    invoke-interface {v9}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/wand/WandManager;->mDisplay:Landroid/view/Display;

    .line 293
    new-instance v0, Lcom/adobe/air/wand/TaskManager;

    iget-object v1, p0, Lcom/adobe/air/wand/WandManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    iget-object v2, p0, Lcom/adobe/air/wand/WandManager;->mDisplay:Landroid/view/Display;

    iget-object v3, p0, Lcom/adobe/air/wand/WandManager;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    iget-object v4, p0, Lcom/adobe/air/wand/WandManager;->mAccelerometer:Lcom/adobe/air/wand/motionsensor/Accelerometer;

    iget-object v5, p0, Lcom/adobe/air/wand/WandManager;->mMagnetometer:Lcom/adobe/air/wand/motionsensor/Magnetometer;

    iget-object v6, p0, Lcom/adobe/air/wand/WandManager;->mGyroscope:Lcom/adobe/air/wand/motionsensor/Gyroscope;

    iget-object v7, p0, Lcom/adobe/air/wand/WandManager;->mVibrator:Landroid/os/Vibrator;

    invoke-direct/range {v0 .. v7}, Lcom/adobe/air/wand/TaskManager;-><init>(Lcom/adobe/air/wand/message/MessageManager;Landroid/view/Display;Lcom/adobe/air/wand/view/TouchSensor;Lcom/adobe/air/wand/motionsensor/Accelerometer;Lcom/adobe/air/wand/motionsensor/Magnetometer;Lcom/adobe/air/wand/motionsensor/Gyroscope;Landroid/os/Vibrator;)V

    iput-object v0, p0, Lcom/adobe/air/wand/WandManager;->mTaskManager:Lcom/adobe/air/wand/TaskManager;

    .line 294
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager;->mTaskManager:Lcom/adobe/air/wand/TaskManager;

    new-instance v1, Lcom/adobe/air/wand/WandManager$TaskListener;

    invoke-direct {v1, p0, v10}, Lcom/adobe/air/wand/WandManager$TaskListener;-><init>(Lcom/adobe/air/wand/WandManager;Lcom/adobe/air/wand/WandManager$1;)V

    invoke-virtual {v0, v1}, Lcom/adobe/air/wand/TaskManager;->registerListener(Lcom/adobe/air/wand/TaskManager$Listener;)V

    .line 295
    return-void
.end method

.method static synthetic access$000(Lcom/adobe/air/wand/WandManager;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/wand/WandManager;

    .prologue
    .line 47
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager;->mProtocolVersion:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$002(Lcom/adobe/air/wand/WandManager;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/wand/WandManager;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 47
    iput-object p1, p0, Lcom/adobe/air/wand/WandManager;->mProtocolVersion:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$100(Lcom/adobe/air/wand/WandManager;)Lcom/adobe/air/wand/view/WandView;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/wand/WandManager;

    .prologue
    .line 47
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager;->mWandView:Lcom/adobe/air/wand/view/WandView;

    return-object v0
.end method

.method static synthetic access$200(Lcom/adobe/air/wand/WandManager;)V
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/wand/WandManager;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 47
    invoke-direct {p0}, Lcom/adobe/air/wand/WandManager;->loadDefaultView()V

    return-void
.end method

.method static synthetic access$300(Lcom/adobe/air/wand/WandManager;)Lcom/adobe/air/wand/TaskManager;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/wand/WandManager;

    .prologue
    .line 47
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager;->mTaskManager:Lcom/adobe/air/wand/TaskManager;

    return-object v0
.end method

.method static synthetic access$400(Lcom/adobe/air/wand/WandManager;)Lcom/adobe/air/wand/connection/Connection;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/wand/WandManager;

    .prologue
    .line 47
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager;->mWandConnection:Lcom/adobe/air/wand/connection/Connection;

    return-object v0
.end method

.method static synthetic access$502(Lcom/adobe/air/wand/WandManager;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/wand/WandManager;
    .param p1, "x1"    # Z

    .prologue
    .line 47
    iput-boolean p1, p0, Lcom/adobe/air/wand/WandManager;->mListenToConfigChange:Z

    return p1
.end method

.method private loadDefaultView()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 353
    :try_start_0
    iget-object v1, p0, Lcom/adobe/air/wand/WandManager;->mAccelerometer:Lcom/adobe/air/wand/motionsensor/Accelerometer;

    invoke-virtual {v1}, Lcom/adobe/air/wand/motionsensor/Accelerometer;->stop()V

    .line 358
    iget-object v1, p0, Lcom/adobe/air/wand/WandManager;->mTaskManager:Lcom/adobe/air/wand/TaskManager;

    invoke-virtual {v1}, Lcom/adobe/air/wand/TaskManager;->terminateRunningTasks()V

    .line 360
    invoke-direct {p0}, Lcom/adobe/air/wand/WandManager;->setDefaultOrientation()V

    .line 365
    iget-object v1, p0, Lcom/adobe/air/wand/WandManager;->mWandView:Lcom/adobe/air/wand/view/WandView;

    invoke-interface {v1}, Lcom/adobe/air/wand/view/WandView;->loadDefaultView()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 372
    return-void

    .line 367
    :catch_0
    move-exception v0

    .line 370
    .local v0, "e":Ljava/lang/Exception;
    throw v0
.end method

.method private setDefaultOrientation()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 379
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager;->mWandView:Lcom/adobe/air/wand/view/WandView;

    sget-object v1, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->INHERIT:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    invoke-interface {v0, v1}, Lcom/adobe/air/wand/view/WandView;->setScreenOrientation(Lcom/adobe/air/wand/view/WandView$ScreenOrientation;)V

    .line 380
    return-void
.end method


# virtual methods
.method public dispose()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 388
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/wand/WandManager;->mIsDisposed:Z

    .line 390
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager;->mTaskManager:Lcom/adobe/air/wand/TaskManager;

    invoke-virtual {v0}, Lcom/adobe/air/wand/TaskManager;->terminateRunningTasks()V

    .line 391
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager;->mTaskManager:Lcom/adobe/air/wand/TaskManager;

    invoke-virtual {v0}, Lcom/adobe/air/wand/TaskManager;->unregisterListener()V

    .line 392
    iput-object v1, p0, Lcom/adobe/air/wand/WandManager;->mTaskManager:Lcom/adobe/air/wand/TaskManager;

    .line 394
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager;->mWandView:Lcom/adobe/air/wand/view/WandView;

    invoke-interface {v0}, Lcom/adobe/air/wand/view/WandView;->unregisterListener()V

    .line 395
    iput-object v1, p0, Lcom/adobe/air/wand/WandManager;->mWandView:Lcom/adobe/air/wand/view/WandView;

    .line 397
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager;->mAccelerometer:Lcom/adobe/air/wand/motionsensor/Accelerometer;

    invoke-virtual {v0}, Lcom/adobe/air/wand/motionsensor/Accelerometer;->dispose()V

    .line 398
    iput-object v1, p0, Lcom/adobe/air/wand/WandManager;->mAccelerometer:Lcom/adobe/air/wand/motionsensor/Accelerometer;

    .line 400
    iput-object v1, p0, Lcom/adobe/air/wand/WandManager;->mDisplay:Landroid/view/Display;

    .line 402
    iput-object v1, p0, Lcom/adobe/air/wand/WandManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    .line 404
    iput-object v1, p0, Lcom/adobe/air/wand/WandManager;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    .line 406
    iput-object v1, p0, Lcom/adobe/air/wand/WandManager;->mVibrator:Landroid/os/Vibrator;

    .line 408
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager;->mWandConnection:Lcom/adobe/air/wand/connection/Connection;

    invoke-interface {v0}, Lcom/adobe/air/wand/connection/Connection;->unregisterListener()V

    .line 409
    iput-object v1, p0, Lcom/adobe/air/wand/WandManager;->mWandConnection:Lcom/adobe/air/wand/connection/Connection;

    .line 411
    invoke-static {}, Lcom/adobe/air/wand/ConnectionChangeReceiver;->unresisterWandConnection()V

    .line 412
    return-void
.end method

.method public focus(Z)V
    .locals 2
    .param p1, "hasFocus"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 302
    iget-boolean v0, p0, Lcom/adobe/air/wand/WandManager;->mIsDisposed:Z

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/Exception;

    const-string v1, "WandManager has been disposed"

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 304
    :cond_0
    if-eqz p1, :cond_1

    .line 306
    invoke-direct {p0}, Lcom/adobe/air/wand/WandManager;->setDefaultOrientation()V

    .line 311
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager;->mWandConnection:Lcom/adobe/air/wand/connection/Connection;

    invoke-interface {v0}, Lcom/adobe/air/wand/connection/Connection;->connect()V

    .line 327
    :goto_0
    iput-boolean p1, p0, Lcom/adobe/air/wand/WandManager;->mHasFocus:Z

    .line 328
    return-void

    .line 318
    :cond_1
    invoke-direct {p0}, Lcom/adobe/air/wand/WandManager;->loadDefaultView()V

    .line 324
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager;->mWandConnection:Lcom/adobe/air/wand/connection/Connection;

    invoke-interface {v0}, Lcom/adobe/air/wand/connection/Connection;->disconnect()V

    goto :goto_0
.end method

.method public hasFocus()Z
    .locals 1

    .prologue
    .line 332
    iget-boolean v0, p0, Lcom/adobe/air/wand/WandManager;->mHasFocus:Z

    return v0
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 2
    .param p1, "config"    # Landroid/content/res/Configuration;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 337
    iget-boolean v0, p0, Lcom/adobe/air/wand/WandManager;->mListenToConfigChange:Z

    if-eqz v0, :cond_0

    iget v0, p1, Landroid/content/res/Configuration;->orientation:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    .line 339
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/wand/WandManager;->mListenToConfigChange:Z

    .line 340
    iget-object v0, p0, Lcom/adobe/air/wand/WandManager;->mWandConnection:Lcom/adobe/air/wand/connection/Connection;

    invoke-interface {v0}, Lcom/adobe/air/wand/connection/Connection;->onReadyForConnection()V

    .line 342
    :cond_0
    return-void
.end method
