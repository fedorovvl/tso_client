.class public interface abstract Lcom/adobe/air/wand/connection/Connection$Listener;
.super Ljava/lang/Object;
.source "Connection.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/wand/connection/Connection;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "Listener"
.end annotation


# virtual methods
.method public abstract onConnectError()V
.end method

.method public abstract onConnectSuccess()V
.end method

.method public abstract onConnectionClose()V
.end method

.method public abstract onConnectionOpen(Ljava/lang/String;)V
.end method

.method public abstract onDisconnectError()V
.end method

.method public abstract onDisconnectSuccess()V
.end method

.method public abstract onReceive(Ljava/lang/String;)V
.end method

.method public abstract updateConnectionToken(Ljava/lang/String;)V
.end method
