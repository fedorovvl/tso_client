.class public Lcom/adobe/air/AndroidNetworkDetector;
.super Ljava/lang/Object;
.source "AndroidNetworkDetector.java"


# static fields
.field private static final NET_DETECT_TAG:Ljava/lang/String; = "AndroidNetworkDetector"


# instance fields
.field private mReceiver:Landroid/content/BroadcastReceiver;

.field private objReference:J

.field private registered:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/AndroidNetworkDetector;->registered:Z

    .line 21
    return-void
.end method

.method static synthetic access$000(Lcom/adobe/air/AndroidNetworkDetector;)J
    .locals 2
    .param p0, "x0"    # Lcom/adobe/air/AndroidNetworkDetector;

    .prologue
    .line 11
    iget-wide v0, p0, Lcom/adobe/air/AndroidNetworkDetector;->objReference:J

    return-wide v0
.end method

.method static synthetic access$100(Lcom/adobe/air/AndroidNetworkDetector;J)V
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AndroidNetworkDetector;
    .param p1, "x1"    # J

    .prologue
    .line 11
    invoke-direct {p0, p1, p2}, Lcom/adobe/air/AndroidNetworkDetector;->callOnNetworkChange(J)V

    return-void
.end method

.method private native callOnNetworkChange(J)V
.end method


# virtual methods
.method public RegisterForNetworkChange(Landroid/content/Context;J)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "objRef"    # J

    .prologue
    .line 25
    iget-boolean v1, p0, Lcom/adobe/air/AndroidNetworkDetector;->registered:Z

    if-nez v1, :cond_0

    .line 29
    :try_start_0
    new-instance v1, Lcom/adobe/air/AndroidNetworkDetector$1;

    invoke-direct {v1, p0}, Lcom/adobe/air/AndroidNetworkDetector$1;-><init>(Lcom/adobe/air/AndroidNetworkDetector;)V

    iput-object v1, p0, Lcom/adobe/air/AndroidNetworkDetector;->mReceiver:Landroid/content/BroadcastReceiver;

    .line 50
    iput-wide p2, p0, Lcom/adobe/air/AndroidNetworkDetector;->objReference:J

    .line 51
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 52
    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v1, "android.net.conn.CONNECTIVITY_CHANGE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 53
    iget-object v1, p0, Lcom/adobe/air/AndroidNetworkDetector;->mReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p1, v1, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 54
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/adobe/air/AndroidNetworkDetector;->registered:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 62
    .end local v0    # "filter":Landroid/content/IntentFilter;
    :cond_0
    :goto_0
    return-void

    .line 57
    :catch_0
    move-exception v1

    goto :goto_0
.end method
