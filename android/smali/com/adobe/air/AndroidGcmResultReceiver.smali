.class public Lcom/adobe/air/AndroidGcmResultReceiver;
.super Landroid/os/ResultReceiver;
.source "AndroidGcmResultReceiver.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/AndroidGcmResultReceiver$Receiver;
    }
.end annotation


# instance fields
.field private mReceiver:Lcom/adobe/air/AndroidGcmResultReceiver$Receiver;


# direct methods
.method public constructor <init>(Landroid/os/Handler;)V
    .locals 1
    .param p1, "handler"    # Landroid/os/Handler;

    .prologue
    .line 33
    invoke-direct {p0, p1}, Landroid/os/ResultReceiver;-><init>(Landroid/os/Handler;)V

    .line 54
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/AndroidGcmResultReceiver;->mReceiver:Lcom/adobe/air/AndroidGcmResultReceiver$Receiver;

    .line 34
    return-void
.end method


# virtual methods
.method protected onReceiveResult(ILandroid/os/Bundle;)V
    .locals 1
    .param p1, "resultCode"    # I
    .param p2, "resultData"    # Landroid/os/Bundle;

    .prologue
    .line 49
    iget-object v0, p0, Lcom/adobe/air/AndroidGcmResultReceiver;->mReceiver:Lcom/adobe/air/AndroidGcmResultReceiver$Receiver;

    if-eqz v0, :cond_0

    .line 50
    iget-object v0, p0, Lcom/adobe/air/AndroidGcmResultReceiver;->mReceiver:Lcom/adobe/air/AndroidGcmResultReceiver$Receiver;

    invoke-interface {v0, p1, p2}, Lcom/adobe/air/AndroidGcmResultReceiver$Receiver;->onReceiveResult(ILandroid/os/Bundle;)V

    .line 52
    :cond_0
    return-void
.end method

.method public setReceiver(Lcom/adobe/air/AndroidGcmResultReceiver$Receiver;)V
    .locals 0
    .param p1, "receiver"    # Lcom/adobe/air/AndroidGcmResultReceiver$Receiver;

    .prologue
    .line 43
    iput-object p1, p0, Lcom/adobe/air/AndroidGcmResultReceiver;->mReceiver:Lcom/adobe/air/AndroidGcmResultReceiver$Receiver;

    .line 44
    return-void
.end method
