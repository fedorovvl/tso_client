.class public Lcom/adobe/air/ShakeListenerService;
.super Landroid/app/Service;
.source "ShakeListenerService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/ShakeListenerService$BackgroundThread;
    }
.end annotation


# instance fields
.field private final AIR_WAND_CLASS_NAME:Ljava/lang/String;

.field private backGroundThread:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

.field private mShakeListener:Lcom/adobe/air/ShakeListener;

.field private mcontext:Landroid/content/Context;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 18
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 21
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/ShakeListenerService;->backGroundThread:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    .line 119
    const-string v0, "com.adobe.air.wand.WandActivity"

    iput-object v0, p0, Lcom/adobe/air/ShakeListenerService;->AIR_WAND_CLASS_NAME:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$000(Lcom/adobe/air/ShakeListenerService;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/ShakeListenerService;

    .prologue
    .line 18
    iget-object v0, p0, Lcom/adobe/air/ShakeListenerService;->mcontext:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$002(Lcom/adobe/air/ShakeListenerService;Landroid/content/Context;)Landroid/content/Context;
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/ShakeListenerService;
    .param p1, "x1"    # Landroid/content/Context;

    .prologue
    .line 18
    iput-object p1, p0, Lcom/adobe/air/ShakeListenerService;->mcontext:Landroid/content/Context;

    return-object p1
.end method

.method static synthetic access$100(Lcom/adobe/air/ShakeListenerService;)Lcom/adobe/air/ShakeListener;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/ShakeListenerService;

    .prologue
    .line 18
    iget-object v0, p0, Lcom/adobe/air/ShakeListenerService;->mShakeListener:Lcom/adobe/air/ShakeListener;

    return-object v0
.end method

.method static synthetic access$102(Lcom/adobe/air/ShakeListenerService;Lcom/adobe/air/ShakeListener;)Lcom/adobe/air/ShakeListener;
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/ShakeListenerService;
    .param p1, "x1"    # Lcom/adobe/air/ShakeListener;

    .prologue
    .line 18
    iput-object p1, p0, Lcom/adobe/air/ShakeListenerService;->mShakeListener:Lcom/adobe/air/ShakeListener;

    return-object p1
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1
    .param p1, "arg0"    # Landroid/content/Intent;

    .prologue
    .line 26
    const/4 v0, 0x0

    return-object v0
.end method

.method public onCreate()V
    .locals 2

    .prologue
    .line 30
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 31
    iget-object v0, p0, Lcom/adobe/air/ShakeListenerService;->backGroundThread:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    if-nez v0, :cond_0

    .line 32
    new-instance v0, Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    invoke-virtual {p0}, Lcom/adobe/air/ShakeListenerService;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Lcom/adobe/air/ShakeListenerService$BackgroundThread;-><init>(Lcom/adobe/air/ShakeListenerService;Landroid/content/Context;)V

    iput-object v0, p0, Lcom/adobe/air/ShakeListenerService;->backGroundThread:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    .line 34
    :cond_0
    return-void
.end method

.method public onDestroy()V
    .locals 2

    .prologue
    .line 54
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    .line 56
    iget-object v1, p0, Lcom/adobe/air/ShakeListenerService;->backGroundThread:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    if-eqz v1, :cond_0

    .line 59
    :try_start_0
    iget-object v1, p0, Lcom/adobe/air/ShakeListenerService;->backGroundThread:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    invoke-virtual {v1}, Lcom/adobe/air/ShakeListenerService$BackgroundThread;->join()V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 64
    :goto_0
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/adobe/air/ShakeListenerService;->backGroundThread:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    .line 66
    :cond_0
    return-void

    .line 60
    :catch_0
    move-exception v0

    .line 62
    .local v0, "e":Ljava/lang/InterruptedException;
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_0
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 2
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "flags"    # I
    .param p3, "startId"    # I

    .prologue
    .line 39
    iget-object v0, p0, Lcom/adobe/air/ShakeListenerService;->backGroundThread:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    if-nez v0, :cond_0

    .line 40
    new-instance v0, Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    invoke-virtual {p0}, Lcom/adobe/air/ShakeListenerService;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Lcom/adobe/air/ShakeListenerService$BackgroundThread;-><init>(Lcom/adobe/air/ShakeListenerService;Landroid/content/Context;)V

    iput-object v0, p0, Lcom/adobe/air/ShakeListenerService;->backGroundThread:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    .line 42
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/ShakeListenerService;->backGroundThread:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    invoke-virtual {v0}, Lcom/adobe/air/ShakeListenerService$BackgroundThread;->getState()Ljava/lang/Thread$State;

    move-result-object v0

    sget-object v1, Ljava/lang/Thread$State;->NEW:Ljava/lang/Thread$State;

    if-eq v0, v1, :cond_1

    iget-object v0, p0, Lcom/adobe/air/ShakeListenerService;->backGroundThread:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    invoke-virtual {v0}, Lcom/adobe/air/ShakeListenerService$BackgroundThread;->getState()Ljava/lang/Thread$State;

    move-result-object v0

    sget-object v1, Ljava/lang/Thread$State;->TERMINATED:Ljava/lang/Thread$State;

    if-ne v0, v1, :cond_3

    .line 43
    :cond_1
    iget-object v0, p0, Lcom/adobe/air/ShakeListenerService;->backGroundThread:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    invoke-virtual {v0}, Lcom/adobe/air/ShakeListenerService$BackgroundThread;->getState()Ljava/lang/Thread$State;

    move-result-object v0

    sget-object v1, Ljava/lang/Thread$State;->TERMINATED:Ljava/lang/Thread$State;

    if-ne v0, v1, :cond_2

    .line 44
    new-instance v0, Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    invoke-virtual {p0}, Lcom/adobe/air/ShakeListenerService;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Lcom/adobe/air/ShakeListenerService$BackgroundThread;-><init>(Lcom/adobe/air/ShakeListenerService;Landroid/content/Context;)V

    iput-object v0, p0, Lcom/adobe/air/ShakeListenerService;->backGroundThread:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    .line 46
    :cond_2
    iget-object v0, p0, Lcom/adobe/air/ShakeListenerService;->backGroundThread:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    invoke-virtual {v0}, Lcom/adobe/air/ShakeListenerService$BackgroundThread;->start()V

    .line 49
    :cond_3
    const/4 v0, 0x1

    return v0
.end method
