.class public final Lcom/adobe/air/DebuggerSettings;
.super Ljava/lang/Object;
.source "DebuggerSettings.java"


# instance fields
.field private debuggerPort:I

.field private host:Ljava/lang/String;

.field private listenForConn:Z


# direct methods
.method constructor <init>()V
    .locals 1

    .prologue
    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    const/4 v0, -0x1

    iput v0, p0, Lcom/adobe/air/DebuggerSettings;->debuggerPort:I

    .line 25
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/DebuggerSettings;->host:Ljava/lang/String;

    .line 26
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/DebuggerSettings;->listenForConn:Z

    .line 28
    return-void
.end method

.method constructor <init>(ILjava/lang/String;Z)V
    .locals 1
    .param p1, "port"    # I
    .param p2, "hostOrIP"    # Ljava/lang/String;
    .param p3, "dolisten"    # Z

    .prologue
    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    const/4 v0, -0x1

    iput v0, p0, Lcom/adobe/air/DebuggerSettings;->debuggerPort:I

    .line 25
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/DebuggerSettings;->host:Ljava/lang/String;

    .line 26
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/DebuggerSettings;->listenForConn:Z

    .line 32
    iput p1, p0, Lcom/adobe/air/DebuggerSettings;->debuggerPort:I

    .line 33
    iput-object p2, p0, Lcom/adobe/air/DebuggerSettings;->host:Ljava/lang/String;

    .line 34
    iput-boolean p3, p0, Lcom/adobe/air/DebuggerSettings;->listenForConn:Z

    .line 35
    return-void
.end method


# virtual methods
.method public getDebuggerPort()I
    .locals 1

    .prologue
    .line 38
    iget v0, p0, Lcom/adobe/air/DebuggerSettings;->debuggerPort:I

    return v0
.end method

.method public getHost()Ljava/lang/String;
    .locals 1

    .prologue
    .line 42
    iget-object v0, p0, Lcom/adobe/air/DebuggerSettings;->host:Ljava/lang/String;

    return-object v0
.end method

.method public setDebugerPort(I)V
    .locals 0
    .param p1, "port"    # I

    .prologue
    .line 50
    iput p1, p0, Lcom/adobe/air/DebuggerSettings;->debuggerPort:I

    .line 51
    return-void
.end method

.method public setHost(Ljava/lang/String;)V
    .locals 0
    .param p1, "hostOrIP"    # Ljava/lang/String;

    .prologue
    .line 54
    iput-object p1, p0, Lcom/adobe/air/DebuggerSettings;->host:Ljava/lang/String;

    .line 55
    return-void
.end method

.method public setListen(Z)V
    .locals 0
    .param p1, "listen"    # Z

    .prologue
    .line 58
    iput-boolean p1, p0, Lcom/adobe/air/DebuggerSettings;->listenForConn:Z

    .line 59
    return-void
.end method

.method public shouldListen()Z
    .locals 1

    .prologue
    .line 46
    iget-boolean v0, p0, Lcom/adobe/air/DebuggerSettings;->listenForConn:Z

    return v0
.end method
