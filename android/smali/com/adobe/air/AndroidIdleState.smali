.class public Lcom/adobe/air/AndroidIdleState;
.super Ljava/lang/Object;
.source "AndroidIdleState.java"


# static fields
.field public static final IDLE_STATE_NORMAL:I = 0x0

.field private static final IDLE_STATE_TAG:Ljava/lang/String; = "AndroidIdleState"

.field public static final IDLE_STATE_WAKEUP:I = 0x1

.field private static mIdleStateManager:Lcom/adobe/air/AndroidIdleState;


# instance fields
.field private mCurrentIdleState:I

.field private mIsWakeUpLockHeld:Z

.field private mKeyGuardLock:Landroid/app/KeyguardManager$KeyguardLock;

.field private mScreenBrightLock:Landroid/os/PowerManager$WakeLock;

.field private sReceiver:Landroid/content/BroadcastReceiver;

.field private sScreenOn:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 26
    const/4 v0, 0x0

    sput-object v0, Lcom/adobe/air/AndroidIdleState;->mIdleStateManager:Lcom/adobe/air/AndroidIdleState;

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;)V
    .locals 3
    .param p1, "c"    # Landroid/content/Context;

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    iput-object v1, p0, Lcom/adobe/air/AndroidIdleState;->mScreenBrightLock:Landroid/os/PowerManager$WakeLock;

    .line 21
    iput-object v1, p0, Lcom/adobe/air/AndroidIdleState;->mKeyGuardLock:Landroid/app/KeyguardManager$KeyguardLock;

    .line 22
    iput-boolean v2, p0, Lcom/adobe/air/AndroidIdleState;->mIsWakeUpLockHeld:Z

    .line 23
    iput v2, p0, Lcom/adobe/air/AndroidIdleState;->mCurrentIdleState:I

    .line 24
    iput-object v1, p0, Lcom/adobe/air/AndroidIdleState;->sReceiver:Landroid/content/BroadcastReceiver;

    .line 25
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/adobe/air/AndroidIdleState;->sScreenOn:Z

    .line 38
    iget-object v1, p0, Lcom/adobe/air/AndroidIdleState;->sReceiver:Landroid/content/BroadcastReceiver;

    if-nez v1, :cond_0

    .line 42
    :try_start_0
    new-instance v1, Lcom/adobe/air/AndroidIdleState$1;

    invoke-direct {v1, p0}, Lcom/adobe/air/AndroidIdleState$1;-><init>(Lcom/adobe/air/AndroidIdleState;)V

    iput-object v1, p0, Lcom/adobe/air/AndroidIdleState;->sReceiver:Landroid/content/BroadcastReceiver;

    .line 63
    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "android.intent.action.SCREEN_ON"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 64
    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v1, "android.intent.action.SCREEN_OFF"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 65
    iget-object v1, p0, Lcom/adobe/air/AndroidIdleState;->sReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p1, v1, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 72
    .end local v0    # "filter":Landroid/content/IntentFilter;
    :cond_0
    :goto_0
    return-void

    .line 67
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public static GetIdleStateManager(Landroid/content/Context;)Lcom/adobe/air/AndroidIdleState;
    .locals 1
    .param p0, "c"    # Landroid/content/Context;

    .prologue
    .line 30
    sget-object v0, Lcom/adobe/air/AndroidIdleState;->mIdleStateManager:Lcom/adobe/air/AndroidIdleState;

    if-nez v0, :cond_0

    .line 31
    new-instance v0, Lcom/adobe/air/AndroidIdleState;

    invoke-direct {v0, p0}, Lcom/adobe/air/AndroidIdleState;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/adobe/air/AndroidIdleState;->mIdleStateManager:Lcom/adobe/air/AndroidIdleState;

    .line 33
    :cond_0
    sget-object v0, Lcom/adobe/air/AndroidIdleState;->mIdleStateManager:Lcom/adobe/air/AndroidIdleState;

    return-object v0
.end method

.method static synthetic access$000(Lcom/adobe/air/AndroidIdleState;)Z
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AndroidIdleState;

    .prologue
    .line 14
    iget-boolean v0, p0, Lcom/adobe/air/AndroidIdleState;->sScreenOn:Z

    return v0
.end method

.method static synthetic access$002(Lcom/adobe/air/AndroidIdleState;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/AndroidIdleState;
    .param p1, "x1"    # Z

    .prologue
    .line 14
    iput-boolean p1, p0, Lcom/adobe/air/AndroidIdleState;->sScreenOn:Z

    return p1
.end method


# virtual methods
.method public ChangeIdleState(Landroid/content/Context;I)V
    .locals 6
    .param p1, "c"    # Landroid/content/Context;
    .param p2, "stateRequested"    # I

    .prologue
    .line 79
    if-nez p2, :cond_0

    .line 82
    :try_start_0
    invoke-virtual {p0}, Lcom/adobe/air/AndroidIdleState;->releaseLock()V

    .line 83
    const/4 v4, 0x0

    iput v4, p0, Lcom/adobe/air/AndroidIdleState;->mCurrentIdleState:I

    .line 114
    :goto_0
    return-void

    .line 88
    :cond_0
    iget-object v4, p0, Lcom/adobe/air/AndroidIdleState;->mScreenBrightLock:Landroid/os/PowerManager$WakeLock;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v4, :cond_1

    .line 92
    :try_start_1
    const-string v4, "power"

    invoke-virtual {p1, v4}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/os/PowerManager;

    move-object v0, v4

    check-cast v0, Landroid/os/PowerManager;

    move-object v3, v0

    .line 93
    .local v3, "pm":Landroid/os/PowerManager;
    const v4, 0x1000000a

    const-string v5, "DoNotDimScreen"

    invoke-virtual {v3, v4, v5}, Landroid/os/PowerManager;->newWakeLock(ILjava/lang/String;)Landroid/os/PowerManager$WakeLock;

    move-result-object v4

    iput-object v4, p0, Lcom/adobe/air/AndroidIdleState;->mScreenBrightLock:Landroid/os/PowerManager$WakeLock;

    .line 94
    const-string v4, "keyguard"

    invoke-virtual {p1, v4}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/app/KeyguardManager;

    move-object v0, v4

    check-cast v0, Landroid/app/KeyguardManager;

    move-object v2, v0

    .line 95
    .local v2, "keyManager":Landroid/app/KeyguardManager;
    const-string v4, "DoNotLockKeys"

    invoke-virtual {v2, v4}, Landroid/app/KeyguardManager;->newKeyguardLock(Ljava/lang/String;)Landroid/app/KeyguardManager$KeyguardLock;

    move-result-object v4

    iput-object v4, p0, Lcom/adobe/air/AndroidIdleState;->mKeyGuardLock:Landroid/app/KeyguardManager$KeyguardLock;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 106
    .end local v2    # "keyManager":Landroid/app/KeyguardManager;
    .end local v3    # "pm":Landroid/os/PowerManager;
    :cond_1
    const/4 v4, 0x1

    :try_start_2
    iput v4, p0, Lcom/adobe/air/AndroidIdleState;->mCurrentIdleState:I

    .line 107
    invoke-virtual {p0}, Lcom/adobe/air/AndroidIdleState;->acquireLock()V

    goto :goto_0

    .line 110
    :catch_0
    move-exception v4

    goto :goto_0

    .line 97
    :catch_1
    move-exception v1

    .line 100
    .local v1, "e":Ljava/lang/Exception;
    const/4 v4, 0x0

    iput-object v4, p0, Lcom/adobe/air/AndroidIdleState;->mScreenBrightLock:Landroid/os/PowerManager$WakeLock;

    .line 101
    const/4 v4, 0x0

    iput-object v4, p0, Lcom/adobe/air/AndroidIdleState;->mKeyGuardLock:Landroid/app/KeyguardManager$KeyguardLock;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0
.end method

.method public acquireLock()V
    .locals 2

    .prologue
    const/4 v1, 0x1

    .line 121
    :try_start_0
    iget v0, p0, Lcom/adobe/air/AndroidIdleState;->mCurrentIdleState:I

    if-ne v0, v1, :cond_0

    iget-boolean v0, p0, Lcom/adobe/air/AndroidIdleState;->mIsWakeUpLockHeld:Z

    if-nez v0, :cond_0

    .line 124
    iget-object v0, p0, Lcom/adobe/air/AndroidIdleState;->mScreenBrightLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->acquire()V

    .line 125
    iget-object v0, p0, Lcom/adobe/air/AndroidIdleState;->mKeyGuardLock:Landroid/app/KeyguardManager$KeyguardLock;

    invoke-virtual {v0}, Landroid/app/KeyguardManager$KeyguardLock;->disableKeyguard()V

    .line 126
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/AndroidIdleState;->mIsWakeUpLockHeld:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 133
    :cond_0
    :goto_0
    return-void

    .line 129
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public releaseLock()V
    .locals 2

    .prologue
    .line 140
    :try_start_0
    iget v0, p0, Lcom/adobe/air/AndroidIdleState;->mCurrentIdleState:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    iget-boolean v0, p0, Lcom/adobe/air/AndroidIdleState;->mIsWakeUpLockHeld:Z

    if-eqz v0, :cond_0

    .line 143
    iget-object v0, p0, Lcom/adobe/air/AndroidIdleState;->mScreenBrightLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->release()V

    .line 144
    iget-object v0, p0, Lcom/adobe/air/AndroidIdleState;->mKeyGuardLock:Landroid/app/KeyguardManager$KeyguardLock;

    invoke-virtual {v0}, Landroid/app/KeyguardManager$KeyguardLock;->reenableKeyguard()V

    .line 145
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/AndroidIdleState;->mIsWakeUpLockHeld:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 152
    :cond_0
    :goto_0
    return-void

    .line 148
    :catch_0
    move-exception v0

    goto :goto_0
.end method
