.class public Lcom/adobe/air/wand/ConnectionChangeReceiver;
.super Landroid/content/BroadcastReceiver;
.source "ConnectionChangeReceiver.java"


# static fields
.field private static mWandConn:Lcom/adobe/air/wand/connection/Connection;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 48
    const/4 v0, 0x0

    sput-object v0, Lcom/adobe/air/wand/ConnectionChangeReceiver;->mWandConn:Lcom/adobe/air/wand/connection/Connection;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 32
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method public static resisterWandConnection(Lcom/adobe/air/wand/connection/Connection;)V
    .locals 0
    .param p0, "conn"    # Lcom/adobe/air/wand/connection/Connection;

    .prologue
    .line 35
    sput-object p0, Lcom/adobe/air/wand/ConnectionChangeReceiver;->mWandConn:Lcom/adobe/air/wand/connection/Connection;

    .line 36
    return-void
.end method

.method public static unresisterWandConnection()V
    .locals 1

    .prologue
    .line 39
    const/4 v0, 0x0

    sput-object v0, Lcom/adobe/air/wand/ConnectionChangeReceiver;->mWandConn:Lcom/adobe/air/wand/connection/Connection;

    .line 40
    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    .line 45
    sget-object v0, Lcom/adobe/air/wand/ConnectionChangeReceiver;->mWandConn:Lcom/adobe/air/wand/connection/Connection;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/adobe/air/wand/ConnectionChangeReceiver;->mWandConn:Lcom/adobe/air/wand/connection/Connection;

    invoke-interface {v0}, Lcom/adobe/air/wand/connection/Connection;->onConnectionChanged()V

    .line 46
    :cond_0
    return-void
.end method
