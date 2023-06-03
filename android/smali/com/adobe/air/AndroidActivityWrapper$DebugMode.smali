.class final enum Lcom/adobe/air/AndroidActivityWrapper$DebugMode;
.super Ljava/lang/Enum;
.source "AndroidActivityWrapper.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/AndroidActivityWrapper;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "DebugMode"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/adobe/air/AndroidActivityWrapper$DebugMode;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

.field public static final enum ConflictMode:Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

.field public static final enum ConnectMode:Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

.field public static final enum ListenMode:Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

.field public static final enum None:Lcom/adobe/air/AndroidActivityWrapper$DebugMode;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .prologue
    const/4 v5, 0x3

    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 1667
    new-instance v0, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    const-string v1, "None"

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;->None:Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    .line 1668
    new-instance v0, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    const-string v1, "ConnectMode"

    invoke-direct {v0, v1, v3}, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;->ConnectMode:Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    .line 1669
    new-instance v0, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    const-string v1, "ListenMode"

    invoke-direct {v0, v1, v4}, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;->ListenMode:Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    .line 1670
    new-instance v0, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    const-string v1, "ConflictMode"

    invoke-direct {v0, v1, v5}, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;->ConflictMode:Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    .line 1666
    const/4 v0, 0x4

    new-array v0, v0, [Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    sget-object v1, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;->None:Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    aput-object v1, v0, v2

    sget-object v1, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;->ConnectMode:Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    aput-object v1, v0, v3

    sget-object v1, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;->ListenMode:Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    aput-object v1, v0, v4

    sget-object v1, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;->ConflictMode:Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    aput-object v1, v0, v5

    sput-object v0, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;->$VALUES:[Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

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
    .line 1666
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/adobe/air/AndroidActivityWrapper$DebugMode;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 1666
    const-class v0, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    return-object v0
.end method

.method public static values()[Lcom/adobe/air/AndroidActivityWrapper$DebugMode;
    .locals 1

    .prologue
    .line 1666
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;->$VALUES:[Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    invoke-virtual {v0}, [Lcom/adobe/air/AndroidActivityWrapper$DebugMode;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    return-object v0
.end method
