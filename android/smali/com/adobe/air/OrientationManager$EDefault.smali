.class public final enum Lcom/adobe/air/OrientationManager$EDefault;
.super Ljava/lang/Enum;
.source "OrientationManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/OrientationManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "EDefault"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/adobe/air/OrientationManager$EDefault;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/adobe/air/OrientationManager$EDefault;

.field public static final enum LANDSCAPE:Lcom/adobe/air/OrientationManager$EDefault;

.field public static final enum PORTRAIT:Lcom/adobe/air/OrientationManager$EDefault;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 44
    new-instance v0, Lcom/adobe/air/OrientationManager$EDefault;

    const-string v1, "PORTRAIT"

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/OrientationManager$EDefault;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/OrientationManager$EDefault;->PORTRAIT:Lcom/adobe/air/OrientationManager$EDefault;

    new-instance v0, Lcom/adobe/air/OrientationManager$EDefault;

    const-string v1, "LANDSCAPE"

    invoke-direct {v0, v1, v3}, Lcom/adobe/air/OrientationManager$EDefault;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/OrientationManager$EDefault;->LANDSCAPE:Lcom/adobe/air/OrientationManager$EDefault;

    const/4 v0, 0x2

    new-array v0, v0, [Lcom/adobe/air/OrientationManager$EDefault;

    sget-object v1, Lcom/adobe/air/OrientationManager$EDefault;->PORTRAIT:Lcom/adobe/air/OrientationManager$EDefault;

    aput-object v1, v0, v2

    sget-object v1, Lcom/adobe/air/OrientationManager$EDefault;->LANDSCAPE:Lcom/adobe/air/OrientationManager$EDefault;

    aput-object v1, v0, v3

    sput-object v0, Lcom/adobe/air/OrientationManager$EDefault;->$VALUES:[Lcom/adobe/air/OrientationManager$EDefault;

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
    .line 44
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/adobe/air/OrientationManager$EDefault;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 44
    const-class v0, Lcom/adobe/air/OrientationManager$EDefault;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/OrientationManager$EDefault;

    return-object v0
.end method

.method public static values()[Lcom/adobe/air/OrientationManager$EDefault;
    .locals 1

    .prologue
    .line 44
    sget-object v0, Lcom/adobe/air/OrientationManager$EDefault;->$VALUES:[Lcom/adobe/air/OrientationManager$EDefault;

    invoke-virtual {v0}, [Lcom/adobe/air/OrientationManager$EDefault;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/adobe/air/OrientationManager$EDefault;

    return-object v0
.end method
