.class public Lcom/adobe/air/WorkerLooper;
.super Ljava/lang/Object;
.source "WorkerLooper.java"


# instance fields
.field private mHandler:Landroid/os/Handler;

.field private mLooper:Landroid/os/Looper;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 34
    invoke-static {}, Landroid/os/Looper;->prepare()V

    .line 35
    new-instance v0, Lcom/adobe/air/customHandler;

    invoke-direct {v0}, Lcom/adobe/air/customHandler;-><init>()V

    iput-object v0, p0, Lcom/adobe/air/WorkerLooper;->mHandler:Landroid/os/Handler;

    .line 36
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/WorkerLooper;->mLooper:Landroid/os/Looper;

    .line 37
    return-void
.end method


# virtual methods
.method public getHandler()Landroid/os/Handler;
    .locals 1

    .prologue
    .line 49
    iget-object v0, p0, Lcom/adobe/air/WorkerLooper;->mHandler:Landroid/os/Handler;

    return-object v0
.end method

.method public quit()V
    .locals 1

    .prologue
    .line 56
    iget-object v0, p0, Lcom/adobe/air/WorkerLooper;->mLooper:Landroid/os/Looper;

    invoke-virtual {v0}, Landroid/os/Looper;->quit()V

    .line 57
    return-void
.end method

.method public start()V
    .locals 0

    .prologue
    .line 43
    invoke-static {}, Landroid/os/Looper;->loop()V

    .line 44
    return-void
.end method
