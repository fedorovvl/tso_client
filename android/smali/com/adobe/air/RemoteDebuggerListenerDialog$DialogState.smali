.class final enum Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;
.super Ljava/lang/Enum;
.source "RemoteDebuggerListenerDialog.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/RemoteDebuggerListenerDialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "DialogState"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;

.field public static final enum StateRuntimeNotReady:Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;

.field public static final enum StateRuntimeTimedOut:Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;

.field public static final enum StateRuntimeWaitingForDebugger:Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .prologue
    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 50
    new-instance v0, Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;

    const-string v1, "StateRuntimeNotReady"

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;->StateRuntimeNotReady:Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;

    new-instance v0, Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;

    const-string v1, "StateRuntimeWaitingForDebugger"

    invoke-direct {v0, v1, v3}, Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;->StateRuntimeWaitingForDebugger:Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;

    new-instance v0, Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;

    const-string v1, "StateRuntimeTimedOut"

    invoke-direct {v0, v1, v4}, Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;->StateRuntimeTimedOut:Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;

    .line 49
    const/4 v0, 0x3

    new-array v0, v0, [Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;

    sget-object v1, Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;->StateRuntimeNotReady:Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;

    aput-object v1, v0, v2

    sget-object v1, Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;->StateRuntimeWaitingForDebugger:Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;

    aput-object v1, v0, v3

    sget-object v1, Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;->StateRuntimeTimedOut:Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;

    aput-object v1, v0, v4

    sput-object v0, Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;->$VALUES:[Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 49
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 49
    const-class v0, Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;

    return-object v0
.end method

.method public static values()[Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;
    .locals 1

    .prologue
    .line 49
    sget-object v0, Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;->$VALUES:[Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;

    invoke-virtual {v0}, [Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/adobe/air/RemoteDebuggerListenerDialog$DialogState;

    return-object v0
.end method
